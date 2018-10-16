//
//  UIViewController+Utilities.swift
//  MyTest
//
//  Created by Stefano Mondino on 04/07/17.
//  Copyright © 2017 stefanomondino.com. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Boomerang
import MBProgressHUD
import pop
import Action
import SpinKit
import Localize_Swift

extension ViewModelBindable where Self: UIViewController {
    func withViewModel(_ viewModel: ViewModelType) -> Self {
        self.bind(to: viewModel, afterLoad: true)
        return self
    }
}

extension UIViewController {
    
    func setup(with viewModel: ViewModelType) -> UIViewController {
        
        let closure = {[unowned self] in
            
            (self as? Collectionable)?.setupCollectionView()
            
            if let selection = (viewModel as? SelectableViewModelType)?.selection {
                (self as? SelectableViewController)?.bind(to: selection)
            }
            (self as? KeyboardAvoidable)?.setupKeyboardAvoiding()
            (self as? ViewModelBindableType)?.bind(to: viewModel)
            if let list = viewModel as? ListViewModelType {
                (self as? Refreshable)?.setupRefreshable(viewModel: list)
            }
            if ((self.navigationController?.viewControllers.count ?? 0) > 1) {
                _ = self.withBackButton()
            }
            if (self.navigationController?.viewControllers.count ?? 0) == 1 && self.presentingViewController != nil {
                _ = self.withCloseButton()
            }
            
        }
        if (self.isViewLoaded) {
            closure()
        } else {
            _ = self.rx
                .viewDidLoad()
                .take(1)
                .subscribe(onNext: {_ in closure()})
        }
        
        return self
    }
    
    @objc func back() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    func withBackButton() -> UIViewController {
        //        let item = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white"), style: .done, target: self, action: #selector(back))
        let item = UIBarButtonItem(title: "menu-back".localized(), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = item
        return self
    }
    
    func withCloseButton() -> UIViewController {
        let item = UIBarButtonItem(title: "menu-cancel".localized(), style: .done, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem = item
        return self
    }
}
