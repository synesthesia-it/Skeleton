//
//  SplashSpec.swift
//  AppTests
//
//  Created by Stefano Mondino on 16/10/2018.
//  Copyright © 2018 Synesthesia. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import Boomerang
@testable import App

class SplashSpec: QuickSpec {
    var viewModel:SplashViewModel!
    override func spec() {
        beforeEach {
            self.viewModel = SplashViewModel()
        }
        describe("the splash viewModel") {
            context("when shown") {
                it("should eventually lead somewhere ") {
                    self.viewModel.selection.execute(.start)
                    //uncomment this and implement logic!
                    //expect(vm.selection.viewModels.any).first(until: 2).to(beAKindOf(SplashViewModel.self))
                }
            }
        }
    }
}
