//
//  UIViewController+Loader.swift
//  App
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SpinKit
import MBProgressHUD

fileprivate extension UIViewController {
    private struct AssociatedKeys {
        static var loaderCount = "loaderCount"
    }
    fileprivate var loaderCount: Int {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.loaderCount) as? Int ?? 0}
        set { objc_setAssociatedObject(self, &AssociatedKeys.loaderCount, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
        
    }
}

extension Style where Base: UIViewController {
    
    func loaderView() -> UIView {
        return RTSpinKitView(style: .stylePulse, color: UIColor.white, spinnerSize: 44)
    }
    
    func loaderContentView() -> UIView {
        return base.navigationController?.view ?? base.view
    }
    
    func showLoader() {
        if (base.loaderCount == 0) {
            DispatchQueue.main.async {
                let hud = MBProgressHUD.showAdded(to: self.loaderContentView(), animated: true)
                let spin = self.loaderView()
                hud.customView = spin
                hud.mode = .customView
                hud.bezelView.color = .clear
            }
        }
        base.loaderCount += 1
        
    }
    
    func hideLoader() {
        let base = self.base
        DispatchQueue.main.async {
            base.loaderCount = max(0, (base.loaderCount ) - 1)
            if (base.loaderCount == 0) {
                MBProgressHUD.hide(for: self.loaderContentView(), animated: true)
            }
        }
        
    }
}
