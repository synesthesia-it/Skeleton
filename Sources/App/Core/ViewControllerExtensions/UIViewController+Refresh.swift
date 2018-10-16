//
//  UIViewController+Refresh.swift
//  App
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import UIKit
import Boomerang


protocol Refreshable: Collectionable {
    func setupRefreshable(viewModel: ListViewModelType)
}
extension Refreshable {
    func setupRefreshable(viewModel: ListViewModelType) {
        let refreshControl = UIRefreshControl()
        refreshControl.rx.bind(to: viewModel.dataHolder.reloadAction, input: nil)
        self.collectionView.addSubview(refreshControl)
        self.collectionView.alwaysBounceVertical = true
    }
}
