//
//  AnalyticsMiddleWare.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public class AnalyticsMiddleWare: FeatureFlow {
    public override func reset() {
        super.reset()
        
        waitActions { (command: Downloading.Start) in
            self.output(Analytics.LogEvent(
                name: "preset_downloading_started",
                params: [
                    "preset_id": command.presetId
                ]
            ))
        }
        
        waitActions { (event: Downloading.Succeeded) in
            self.output(Analytics.LogEvent(
                name: "preset_downloading_succeded",
                params: [
                    "preset_id": event.presetId
                ]
            ))
        }
    }
}

