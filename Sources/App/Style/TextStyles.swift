//
//  Styles.swift
//  App
//
//  Created by Stefano Mondino on 11/08/18.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation
import BonMot
import UIKit
import RxCocoa
import RxSwift

enum StyleClass: String {
    case mainText
    case mainTextBold
    case mainTitle

    var stringStyle: StringStyle {
        switch self {
            
        case .mainText : return StringStyle(.font(.type(type: .lato, weight: .regular, size: 15)), .color(.textGrey))
        case .mainTextBold : return StringStyle(.font(.type(type: .lato, weight: .bold, size: 15)), .color(.textGrey))
        case .mainTitle : return StringStyle(.font(.type(type: .lato, weight: .regular, size: 25)), .color(.white))
    
        }
    }
}

extension Reactive where Base: UILabel {
    public var styledText: Binder<String?> {
        return Binder(self.base) { label, text in
            label.styledText = text
        }
    }
}
