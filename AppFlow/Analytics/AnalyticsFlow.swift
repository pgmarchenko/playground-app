//
//  AnalyticsMiddleWare.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public class AnalyticsFlow: FeatureFlow {
    public override func reset() {
        super.reset()
        
        presetDownloadingAnalytics()
        
        downloadScreenTimeAnalytics()
        magiColorScreenTimeAnalytics()
    }
}

extension AnalyticsFlow {
    private func presetDownloadingAnalytics() {
        var downloadingStartTime: TimeInterval = 0
        
        waitEvents { (event: AnalyticsEvent<Downloading.Start, TimeParams>) in
            downloadingStartTime = event.params.time
            self.output(Analytics.LogEvent(name: "downloading_started"))
        }
        
        waitEvents { (event: AnalyticsEvent<Downloading.Succeeded, TimeParams>) in
            self.output(Analytics.LogEvent(
                name: "downloading_succeded",
                params: [
                    "downloading_time": "\(event.params.time - downloadingStartTime)"
                ]
            ))
            downloadingStartTime = 0
        }
        
        waitEvents { (event: AnalyticsEvent<Downloading.Failed, TimeParams>) in
            self.output(Analytics.LogEvent(
                name: "downloading_failed",
                params: [
                    "downloading_time": "\(event.params.time - downloadingStartTime)"
                ]
            ))
        }
        
        waitEvents { (event: AnalyticsEvent<Downloading.Cancel, TimeParams>) in
            self.output(Analytics.LogEvent(
                name: "downloading_cancelled",
                params: [
                    "downloading_time": "\(event.params.time - downloadingStartTime)"
                ]
            ))
        }
    }
    
    fileprivate func downloadScreenTimeAnalytics() {
        var appearTime: TimeInterval = 0
        waitEvents { (event: AnalyticsEvent<DownloadScreen.DidAppear, TimeParams>) in
            appearTime = event.params.time
        }
        
        waitEvents { (event: AnalyticsEvent<DownloadScreen.DidDisappear, TimeParams>) in
            self.output(Analytics.LogEvent(
                name: "screen_time",
                params: [
                    "screen": "download",
                    "time": "\(event.params.time - appearTime)"
                ]
            ))
        }
    }
    
    fileprivate func magiColorScreenTimeAnalytics() {
        var appearTime: TimeInterval = 0
        waitEvents { (event: AnalyticsEvent<MagiColorScreen.DidAppear, TimeParams>) in
            appearTime = event.params.time
        }
        
        waitEvents { (event: AnalyticsEvent<MagiColorScreen.DidDisappear, TimeParams>) in
            self.output(Analytics.LogEvent(
                name: "screen_time",
                params: [
                    "screen": "magicolor",
                    "time": "\(event.params.time - appearTime)"
                ]
            ))
        }
    }
}
