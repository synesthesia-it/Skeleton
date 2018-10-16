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
