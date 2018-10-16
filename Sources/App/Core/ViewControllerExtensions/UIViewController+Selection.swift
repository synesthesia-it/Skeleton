//
//  ViewController+Selection.swift
//  Test
//
//  Created by Stefano Mondino on 21/04/18.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Boomerang
import Action
import ModelLayer

protocol SelectableViewController {
    func bind(to selection: Selection)
}

extension ObservableType where E == ActionError {
    public func unwrap() -> Observable<APPError?> {
        return self.map {
            switch $0 {
            case .underlyingError(let error): return error as? APPError
            default: return nil
            }
        }
    }
}

extension SelectableViewController where Self: UIViewController {
    func bind(to selection: Selection) {
        selection.errors.asObservable().unwrap()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
            if let error = $0, let vc = self {
                Router.error(error, from: vc).execute()
            }
        }).disposed(by: self.disposeBag)
        
        selection.executing
            .observeOn(MainScheduler.instance)
            .debounce(0.1, scheduler: MainScheduler.instance)
            .bind(to: self.rx.isLoading())
            .disposed(by: disposeBag)
        
        selection.elements.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .invalidateLayout :
                DispatchQueue.main.async {[weak self] in
                    (self as? Collectionable)?.collectionView.performBatchUpdates({
                        (self as? Collectionable)?.collectionView.collectionViewLayout.invalidateLayout()
                    }, completion: nil)
                }
            case .viewModel(let viewModel) : Router.from(self, viewModel: viewModel).execute()
                
            case .dismiss: self.dismiss(animated: true, completion: nil)
                
            case .back: self.navigationController?.popViewController(animated: true)
                
            case .restart : Router.restart()
            default : break
            }
        }).disposed(by: disposeBag)
    }
}
