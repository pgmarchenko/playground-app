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
        
        waitEvents(handleDownloadScreenShowed)
        waitEvents(handleMagiColorScreenShowed)
    }
}

private extension AppFlow {
    func handleDownloadScreenShowed(_ it: DownloadScreen.Showed) {
        removeAllChildFlows()
        
        output(MagiColorScreen.SetWhiteMode())
        
        addChildFlow(DownloadAndOpenFlow())
    }
    
    func handleMagiColorScreenShowed(_ it: MagiColorScreen.Showed) {
        removeAllChildFlows()
        
        output(DownloadWaitingOverlay.Hide())
        
        addChildFlow(MagiColorScreenFlow())
    }
}
