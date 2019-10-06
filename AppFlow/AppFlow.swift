//
//  AppFlow.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 6/22/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation
import AppEntities

public class AppFlow: FeatureFlow {
    public override func reset() {
        super.reset()
        
        waitEvents(handleDownloadScreenWillAppear)
        waitEvents(handleDownloadScreenDidAppear)
        waitEvents(handleMagiColorScreenWillAppear)
        waitEvents(handleMagiColorScreenDidAppear)
    }
}

private extension AppFlow {
    func handleDownloadScreenWillAppear(_: UI.WillAppear<DownloadScreen>) {
        output(UI.Hide(DownloadWaitingOverlay()))
    }
    
    func handleDownloadScreenDidAppear(_: UI.DidAppear<DownloadScreen>) {
        removeAllChildFlows()
        
        addChildFlow(DownloadAndOpenFlow())
    }
    
    func handleMagiColorScreenWillAppear(_: UI.WillAppear<MagiColorScreen>) {
        output(MagiColorScreen.SetDefaultMode())
    }
    
    func handleMagiColorScreenDidAppear(_: UI.DidAppear<MagiColorScreen>) {
        removeAllChildFlows()
        
        addChildFlow(MagiColorScreenFlow())
    }
}
