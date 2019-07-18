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

import RxSwift

class DownloadAndOpenFlowTests: QuickSpec {
    override func spec() {
        describe("Download and Open") {
            var flow = DownloadAndOpenFlow(record: true)
            
            beforeEach {
                flow = DownloadAndOpenFlow(record: true)
                flow.dispatch(DownloadScreen.DownloadAndOpen(id: "test", premium: false, isFree: true))
                
                expect(flow.popRecordedCommands()) == [
                    DownloadWaitingOverlay.Show(),
                    Downloading.Start(presetId: "test")
                ]
            }
            
            context("Cancelled") {
                beforeEach {
                    flow.dispatch(DownloadScreen.DownloadingCancelled())
                }
                
                it("Hides waitings overlay") {
                    expect(flow.popRecordedCommands()) == [
                        DownloadWaitingOverlay.Hide(),
                        Downloading.Cancel()
                    ]
                }
            }
        }
        
        describe("Download with progress") {
            let flow = DownloadAndOpenFlow(record: true)
            
            expectFlow(flow, [
                onEvents([
                        DownloadScreen.DownloadAndOpen(id: "test", premium: false, isFree: true)
                    ],
                    commands: [
                        DownloadWaitingOverlay.Show(),
                        Downloading.Start(presetId: "test")
                    ]
                ),
                branches(
                    [
                        onEvents([
                            Downloading.Progress(current: 10, total: 100)
                            ],
                                 commands: [
                                    DownloadWaitingOverlay.ShowProgress(current: 10, total: 100)
                            ]
                        ),
                        onEvents([
                            Downloading.Succeeded(presetId: "test")
                            ], commands: [
                                DownloadWaitingOverlay.Hide(),
                                MagiColorScreen.Show()
                            ]
                        )
                    ],
                    [
                        onEvents([
                                Downloading.Failed(presetId: "test")
                            ],
                            commands: [
                                DownloadWaitingOverlay.Hide()
                            ]
                        )
                    ]
                )
                
            ])
        }
    }
}

