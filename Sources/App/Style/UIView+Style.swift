//
//  UIView+Style.swift
//  App
//
//  Created by Stefano Mondino on 11/08/18.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import UIKit

extension Style where Base: UILabel {
    func text(with style: StyleClass) {
        self.base.bonMotStyle = style.stringStyle
    }
}
