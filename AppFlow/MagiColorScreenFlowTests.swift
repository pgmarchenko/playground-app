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
import AppEntities

import RxSwift

class MagiColorScreenFlowTests: QuickSpec {
    override func spec() {
        describe("Init") {
            let flow = MagiColorScreenFlow(record: true)
            
            expectFlow(flow, [
                onEvents(
                    [
                        MagiColorScreen.ColorButtonTouched(),
                    ],
                    commands: [
                        MagiColorScreen.SetColorMode()
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.ResetButtonTouched(),
                    ],
                    commands: [
                        MagiColorScreen.SetDefaultMode()
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
                        MagiColorScreen.ColorButtonTouched(),
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
                        MagiColorScreen.ColorButtonTouched(),
                        MagiColorScreen.TutorialSwitcherTouched(),
                        MagiColorScreen.ResetButtonTouched(),
                        MagiColorScreen.TutorialSwitcherTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetColorMode(),
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
                        MagiColorScreen.SetDefaultMode()
                    ]
                )
                ]
            )
        }
    }
}
