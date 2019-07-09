//
//  AppFlow.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 6/22/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public class AppFlow: FeatureFlow {
    public override func reset() {
        super.reset()
        
        waitEvents(handleDownloadScreenDidAppear)
        waitEvents(handleMagiColorScreenDidAppear)
    }
}

private extension AppFlow {
    func handleDownloadScreenDidAppear(_: DownloadScreen.DidAppear) {
        removeAllChildFlows()
        
        output(MagiColorScreen.SetWhiteMode())
        
        addChildFlow(DownloadAndOpenFlow())
    }
    
    func handleMagiColorScreenDidAppear(_: MagiColorScreen.DidAppear) {
        removeAllChildFlows()
        
        output(DownloadWaitingOverlay.Hide())
        
        addChildFlow(MagiColorScreenFlow())
    }
}
