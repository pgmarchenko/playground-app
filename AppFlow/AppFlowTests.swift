//
//  AppFlowTests.swift
//  AppFlowTests
//
//  Created by Pavel Marchanka on 6/22/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation
import Quick
import Nimble

import AppFlow

import RxSwift

class AppFlowTests: QuickSpec {
    override func spec() {
        describe("Init") {
            let flow = AppFlow(record: true)
            
            expectFlow(flow, [
                onEvents(
                    startingEvents,
                    commands: [
                        MagiColorScreen.SetWhiteMode()
                    ]
                ),
                onEvents(
                    [
                        DownloadScreen.DownloadAndOpen(id: "test", premium: false, isFree: true)
                    ],
                    commands: downloadingCommands(presetId: "test")
                ),
                onEvents(
                    [
                        DownloadScreen.DownloadingCancelled()
                    ],
                    commands: [
                        DownloadWaitingOverlay.Hide(),
                        Downloading.Cancel()
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.DidAppear(),
                    ],
                    commands: [
                        DownloadWaitingOverlay.Hide()
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.RedButtonTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetRedMode()
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.ResetButtonTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetWhiteMode()
                    ]
                ),
                onEvents(
                    [
                        DownloadScreen.DidAppear(),
                    ],
                    commands: [
                        MagiColorScreen.SetWhiteMode()
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.RedButtonTouched(),
                        MagiColorScreen.ResetButtonTouched()
                    ],
                    commands: [
                        // должны быть проигнорированы
                    ]
                ),
                onEvents(
                    [
                        DownloadScreen.DownloadAndOpen(id: "test", premium: false, isFree: true)
                    ],
                    commands: downloadingCommands(presetId: "test")
                )
                
//                branches(
//                    [
//                        (
//                            onEvents: [MenuSelected()],
//                            commands: [MenuScreenShow()]
//                        ),
//                        menuExpectations()
//                    ],
//                    [
//                        (
//                            onEvents: [SequencerSelected()],
//                            commands: [SequencerScreenShow()]
//                        ),
//                        sequencerExpectations()
//                    ]
//                )
            ])
        }
    }
}

let startingEvents = [
    DownloadScreen.DidAppear()
]

func downloadingCommands(presetId: String) -> [FeatureFlowCommand] {
    return [
        DownloadWaitingOverlay.Show(),
        Downloading.Start(presetId: presetId)
    ]
}


// сбор данных, цепочки зависимостей, на примере урока битскул 
