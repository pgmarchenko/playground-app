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
                flow.dispatch(DownloadScreen.DownloadAndOpen())
                
                expect(flow.popRecordedCommands()) == [
                    DownloadWaitingOverlay.Show()
                ]
            }
            
            context("Cancelled") {
                beforeEach {
                    flow.dispatch(DownloadScreen.DownloadingCancelled())
                }
                
                it("Hides waitings overlay") {
                    expect(flow.popRecordedCommands()) == [
                        DownloadWaitingOverlay.Hide()
                    ]
                }
            }
        }
    }
}

