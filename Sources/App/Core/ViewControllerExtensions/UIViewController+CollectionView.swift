//
//  UIViewController+CollectionView.swift
//  App
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Boomerang

protocol Collectionable: KeyboardAvoidable {
    var collectionView: UICollectionView! {get}
    func setupCollectionView()
}

extension Collectionable  where Self: UIViewController {
    var keyboardAvoidingView: UIView { return collectionView }
    func setupCollectionView() {
        self.collectionView.backgroundColor = .clear
        
    }
}
