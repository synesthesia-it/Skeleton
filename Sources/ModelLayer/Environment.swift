//
//  Environment.swift
//  App
//
//  Created by Stefano Mondino on 17/07/18.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation

public enum Environment: String {
    
    case devel
    case production
    
    public var name:String {
        return self.rawValue
    }
    
    public static func setup(with environment:Environment) {
        EnvironmentManager.currentEnvironment = environment
    }
    
    public static var current:Environment {
        return EnvironmentManager.currentEnvironment
    }
    
}

fileprivate class EnvironmentManager {
    
    static var currentEnvironment:Environment! = .devel
    
}
