//
//  MagiColorScreenFlowTests.swift
//  AppFlowTests
//
//  Created by Pavel Marchanka on 7/9/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation
import Quick
import Nimble

import AppFlow

import RxSwift

class MagiColorScreenFlowTests: QuickSpec {
    override func spec() {
        describe("Init") {
            let flow = MagiColorScreenFlow(record: true)
            
            expectFlow(flow, [
                onEvents(
                    [
                        MagiColorScreen.RedButtonTouched(),
                    ],
                    commands: [
                        MagiColorScreen.SetRedMode()
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.ResetButtonTouched(),
                    ],
                    commands: [
                        MagiColorScreen.SetWhiteMode()
                    ]
                )
            ])
        }
        
        describe("Tutorial for red button") {
            let flow = MagiColorScreenFlow(record: true)
            
            expectFlow(flow, [
                onEvents(
                    [
                        MagiColorScreen.TutorialSwitcherTouched(),
                        MagiColorScreen.RedButtonTouched(),
                        MagiColorScreen.TutorialSwitcherTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetTutorialTitle("Tutorial mode!"),
                        MagiColorScreen.SetTutorialTitle("Will change background color to self color"),
                        MagiColorScreen.SetTutorialTitle(nil)
                    ]
                )
            ])
        }
        
        describe("Tutorial for reset button") {
            let flow = MagiColorScreenFlow(record: true)
            
            expectFlow(flow, [
                onEvents(
                    [
                        MagiColorScreen.RedButtonTouched(),
                        MagiColorScreen.TutorialSwitcherTouched(),
                        MagiColorScreen.ResetButtonTouched(),
                        MagiColorScreen.TutorialSwitcherTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetRedMode(),
                        MagiColorScreen.SetTutorialTitle("Tutorial mode!"),
                        MagiColorScreen.SetTutorialTitle("Will change colors back"),
                        MagiColorScreen.SetTutorialTitle(nil)
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.ResetButtonTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetWhiteMode()
                    ]
                )
                ]
            )
        }
    }
}
