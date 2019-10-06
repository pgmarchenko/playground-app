//
//  DownloadScreenFlowTests.swift
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

class DownloadAndOpenFlowTests: QuickSpec {
    override func spec() {
        describe("Download and Open") {
            var flow = DownloadAndOpenFlow(record: true)
            
            beforeEach {
                flow = DownloadAndOpenFlow(record: true)
                flow.dispatch(
                    ExtendedEvent(
                        DownloadScreen.OpenMagicolorScreen(id: ""),
                        params: MagiColorScreen.ColorsParams(primary: "green", default: "white")
                    )
                )
                
                expect(flow.popRecordedCommands()) == [
                    UI.Show(DownloadWaitingOverlay()),
                    Downloading.Start()
                ]
            }
            
            context("Cancelled") {
                beforeEach {
                    flow.dispatch(DownloadScreen.DownloadingCancelled())
                }
                
                it("Hides waitings overlay") {
                    expect(flow.popRecordedCommands()) == [
                        UI.Hide(DownloadWaitingOverlay()),
                        Downloading.Cancel()
                    ]
                }
            }
        }
        
        describe("Download with progress") {
            let flow = DownloadAndOpenFlow(record: true)
            let params = MagiColorScreen.ColorsParams(primary: "green", default: "white")
            
            expectFlow(flow, [
                onEvents([
                        ExtendedEvent(
                            DownloadScreen.OpenMagicolorScreen(id: ""),
                            params: params
                        )
                    ],
                    commands: [
                        UI.Show(DownloadWaitingOverlay()),
                        Downloading.Start()
                    ]
                ),
                branches(
                    [
                        onEvents([
                                Downloading.Progress(current: 10, total: 100)
                            ], commands: [
                                    DownloadWaitingOverlay.ShowProgress(current: 10, total: 100)
                            ]
                        ),
                        onEvents([
                                Downloading.Succeeded()
                            ], commands: [
                                UI.Hide(DownloadWaitingOverlay()),
                                MagiColorScreen.SetColors(params: params),
                                UI.Show(MagiColorScreen())
                            ]
                        )
                    ],
                    [
                        onEvents([
                                Downloading.Failed()
                            ], commands: [
                                UI.Hide(DownloadWaitingOverlay())
                            ]
                        )
                    ]
                )
                
            ])
        }
    }
}

