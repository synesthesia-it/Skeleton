//
//  Environment.swift
//  App
//
//  Created by Stefano Mondino on 17/07/18.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation

public protocol EnvironmentType {
    var name: String { get }
    var logLevel: LogLevel { get }
}

extension EnvironmentType {
    public static func setup(with environment: EnvironmentType) {
        EnvironmentManager.currentEnvironment = environment
    }
    
    public static var current: EnvironmentType {
        return EnvironmentManager.currentEnvironment
    }
    
}

private class EnvironmentManager {
    private static var _env: EnvironmentType?
    
    static var currentEnvironment: EnvironmentType {
        get {
            guard let env = _env else {
                fatalError("No environment set")
            }
            return env
        }
        set {
            if _env != nil {
                fatalError("Environment already set!")
            }
            _env = newValue
        }
    }
    
}
