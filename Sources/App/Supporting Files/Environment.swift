//
//  Environments.swift
//  App
//
//  Created by Stefano Mondino on 26/09/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation
import ModelLayer

enum Environment: String, EnvironmentType {
    case devel
    case production
    
    static func bootstrap() {
        Environment.setup(with: Environment.default)
    }
    
    private static var `default`: Environment {
        let environment: Environment
        
        //Entry point to add more configurations
        #if DEVEL
        environment = .devel
        #else
        environment = .production
        #endif
        return environment
    }
    
    var name: String {
        return self.rawValue
    }
    var endpoint: String {
        switch self {
        case .devel: return ""
        case .production: return ""
        }
    }
    var logLevel: LogLevel {
        switch self {
        case .production: return .none
        default: return .verbose
        }
        
    }
}
