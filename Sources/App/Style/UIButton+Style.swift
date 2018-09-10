//
//  UIButton+Style.swift
//  App
//
//  Created by Stefano Mondino on 10/08/18.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import UIKit
import BonMot

extension Style where Base: UIButton {
    func text(with style: StyleClass) {
        base.bonMotStyle = style.stringStyle
    }
}
