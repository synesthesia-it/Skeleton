//
//  NSObject+Style.swift
//  App
//
//  Created by Stefano Mondino on 12/08/18.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import UIKit

public struct Style<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol StyleCompatible {
    
    associatedtype CompatibleType
    
    static var style: Style<CompatibleType>.Type { get set }
    
    var style: Style<CompatibleType> { get set }
}

extension StyleCompatible {
    public static var style: Style<Self>.Type {
        get {
            return Style<Self>.self
        }
        set { }
    }
    public var style: Style<Self> {
        get {
            return Style(self)
        }
        set { }
    }
}

extension NSObject: StyleCompatible {}
