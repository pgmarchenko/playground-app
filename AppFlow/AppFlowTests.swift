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
import AppEntities

import RxSwift

class AppFlowTests: QuickSpec {
    override func spec() {
        describe("Init") {
            let flow = AppFlow(record: true)
            
            expectFlow(flow, [
                onEvents(
                    [
                        UI.WillAppear(DownloadScreen()),
                    ],
                    commands: [
                        UI.Hide(DownloadWaitingOverlay())
                    ]
                ),
                onEvents(
                    [
                        UI.DidAppear(DownloadScreen()),
                    ],
                    commands: []
                ),
                onEvents(
                    [
                        ExtendedEvent(
                            DownloadScreen.OpenMagicolorScreen(id: ""),
                            params: MagiColorScreen.ColorsParams(primary: "green", default: "white")
                        )
                    ],
                    commands: [
                        UI.Show(DownloadWaitingOverlay()),
                        Downloading.Start()
                    ]
                ),
                onEvents(
                    [
                        DownloadScreen.DownloadingCancelled()
                    ],
                    commands: [
                        UI.Hide(DownloadWaitingOverlay()),
                        Downloading.Cancel()
                    ]
                ),
                onEvents(
                    [
                        UI.DidAppear(MagiColorScreen()),
                    ],
                    commands: []
                ),
                onEvents(
                    [
                        MagiColorScreen.ColorButtonTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetColorMode()
                    ]
                ),
                onEvents(
                    [
                        MagiColorScreen.ResetButtonTouched()
                    ],
                    commands: [
                        MagiColorScreen.SetDefaultMode()
                    ]
                ),
                onEvents(
                    [
                        UI.DidAppear(DownloadScreen()),
                    ],
                    commands: []
                ),
                onEvents(
                    [
                        MagiColorScreen.ColorButtonTouched(),
                        MagiColorScreen.ResetButtonTouched()
                    ],
                    commands: [
                        // должны быть проигнорированы
                    ]
                ),
                onEvents(
                    [
                        ExtendedEvent(
                            DownloadScreen.OpenMagicolorScreen(id: ""),
                            params: MagiColorScreen.ColorsParams(primary: "green", default: "white")
                        )
                    ],
                    commands: [
                        UI.Show(DownloadWaitingOverlay()),
                        Downloading.Start()
                    ]
                )
            ])
        }
    }
}
