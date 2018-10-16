//
//  UIViewController+Rx.swift
//  App
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var disposeBag = "vc_disposeBag"
    }
    
    public var disposeBag: DisposeBag {
        var disposeBag: DisposeBag
        
        if let lookup = objc_getAssociatedObject(self, &AssociatedKeys.disposeBag) as? DisposeBag {
            disposeBag = lookup
        } else {
            disposeBag = DisposeBag()
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, disposeBag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return disposeBag
    }
}

extension Reactive where Base: UIViewController {
    func viewDidLoad() -> Observable<()> {
        return methodInvoked(#selector(UIViewController.viewDidLoad)).map {_ in return ()}
    }
    func viewDidAppear() -> Observable<()> {
        return methodInvoked(#selector(UIViewController.viewDidAppear(_:))).map {_ in return ()}
    }
    func viewWillAppear() -> Observable<()> {
        return methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map {_ in return ()}
    }
    func viewDisappear() -> Observable<()> {
        return methodInvoked(#selector(UIViewController.viewDidDisappear(_:))).map {_ in return ()}
    }
    func viewWillDisappear() -> Observable<()> {
        return methodInvoked(#selector(UIViewController.viewWillDisappear(_:))).map {_ in return ()}
    }
    
    func isLoading() -> Binder<Bool> {
        return Binder(base) { base, isLoading in
            isLoading ? base.style.showLoader() : base.style.hideLoader()
        }
    }
}
