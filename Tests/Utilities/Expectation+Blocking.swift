//
//  Expectation+Blocking.swift
//  Pods
//
//  Created by Mostafa Amer on 11.05.17.
//
//

import Nimble
import RxSwift
import RxBlocking

public extension Expectation where T: ObservableType {

    /**
     Expectation with sequence's first element
     
     Transforms the expression by blocking sequence and returns its first element.
    */
    public func first(until timeout: RxTimeInterval? = nil) -> Expectation<T.E> {
        return transform { source in
            try source?.toBlocking(timeout: timeout).first()
        }
    }
    /**
     Expectation with sequence's last element

     Transforms the expression by blocking sequence and returns its last element.
     */
    public func last(until timeout: RxTimeInterval? = nil) -> Expectation<T.E> {
    return transform { source in
        try source?.toBlocking(timeout: timeout).last()
    }
    }

    /**
     Expectation with all sequence's elements

     Transforms the expression by blocking sequence and returns its elements.
     */
    public func array(until timeout: RxTimeInterval? = nil) -> Expectation<[T.E]> {
        return transform { source in
            try source?.toBlocking(timeout: timeout).toArray()
        }
    }
}
