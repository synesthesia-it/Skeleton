//
//  UIViewController+KeyboardAvoid.swift
//  App
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import IHKeyboardAvoiding

protocol KeyboardAvoidable {
    var keyboardAvoidingView: UIView { get }
    func setupKeyboardAvoiding()
}

extension KeyboardAvoidable where Self: UIViewController {
    func setupKeyboardAvoiding() {
        let vc = self as UIViewController
        vc.rx
            .methodInvoked(#selector(UIViewController.viewDidAppear(_:)))
            .subscribe(onNext: { [weak self] _ in
                KeyboardAvoiding.avoidingBlock = nil
                KeyboardAvoiding.avoidingView = self?.keyboardAvoidingView
            })
            .disposed(by: vc.disposeBag)
        
    }
}
