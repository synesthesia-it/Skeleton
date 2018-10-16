//
//  APITests.swift
//  ModelLayerTests
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import ModelLayer

class APISpec: QuickSpec {
    override func spec() {
        describe("the example API") {
            context("when called with connection") {
                it("should return a json") {
                    DataManager.setupForTests()
                    expect(DataManager.rx.example()).first == ()
                }
            }
        }
    }
}
