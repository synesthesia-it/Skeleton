//
//  Utilities.swift
//  AppTests
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation
import RxSwift
import RxBlocking

import Nimble

extension Observable {
    var any: Observable<Any> {
        return map { $0 }
    }
}

public extension Expectation where T: ObservableType {
    
    /**
     Expectation with sequence's first element
     
     Transforms the expression by blocking sequence and returns its first element.
     */
    public var first: Expectation<T.E> {
        return transform { source in
            try source?.toBlocking().first()
        }
    }
    /**
     Expectation with sequence's last element
     
     Transforms the expression by blocking sequence and returns its last element.
     */
    public var last: Expectation<T.E> {
        return transform { source in
            try source?.toBlocking().last()
        }
    }
    
    /**
     Expectation with all sequence's elements
     
     Transforms the expression by blocking sequence and returns its elements.
     */
    public var array: Expectation<[T.E]> {
        return transform { source in
            try source?.toBlocking().toArray()
        }
    }
}
