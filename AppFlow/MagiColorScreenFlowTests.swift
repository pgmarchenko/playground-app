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
                (
                    onEvents: [
                        MagiColorScreen.RedButtonTouched(),
                    ],
                    commands: [
                        MagiColorScreen.SetRedMode()
                    ]
                ),
                (
                    onEvents: [
                        MagiColorScreen.RedButtonTouched(),
                    ],
                    commands: [
                    ]
                ),
                (
                    onEvents: [
                        MagiColorScreen.ResetButtonTouched(),
                    ],
                    commands: [
                        MagiColorScreen.SetWhiteMode()
                    ]
                )
            ])
        }
        
        describe("Tutorial") {
            let flow = MagiColorScreenFlow(record: true)
            
            expectFlow(flow, [
                (
                    onEvents: [
                        MagiColorScreen.TutorialSwitcherTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetTutorialTitle("Tutorial mode!")
                    ]
                ),
                (
                    onEvents: [
                        MagiColorScreen.RedButtonTouched(),
                    ],
                    commands: [
                        MagiColorScreen.SetTutorialTitle("Will change background color to self color")
                    ]
                ),
                (
                    onEvents: [
                        MagiColorScreen.TutorialSwitcherTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetTutorialTitle(nil)
                    ]
                ),
                (
                    onEvents: [
                        MagiColorScreen.RedButtonTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetRedMode()
                    ]
                ),
                (
                    onEvents: [
                        MagiColorScreen.TutorialSwitcherTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetTutorialTitle("Tutorial mode!")
                    ]
                ),
                (
                    onEvents: [
                        MagiColorScreen.ResetButtonTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetTutorialTitle("Will change colors back")
                    ]
                )
            ])
        }
    }
}
