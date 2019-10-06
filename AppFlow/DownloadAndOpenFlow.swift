//
//  DownloadScreenFlow.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 6/22/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation
import AppEntities

public class DownloadAndOpenFlow: FeatureFlow {
    public override func reset() {
        super.reset()
        
        waitSingleEvent(handleDownloadAndOpen)
    }
}

private extension DownloadAndOpenFlow {
    func handleDownloadAndOpen(ee: ExtendedEvent<DownloadScreen.OpenMagicolorScreen, MagiColorScreen.ColorsParams>) {
        output(UI.Show(DownloadWaitingOverlay()))
        output(Downloading.Start())
        
        removeHandlers()
        waitEvents(handleDownloadProgress)
        waitSingleEvent(handleDownloadCancelled)
        waitSingleEvent(handleDownloadFailed)
        
        waitSingleEvent { (event: Downloading.Succeeded) in
            self.output(UI.Hide(DownloadWaitingOverlay()))
            self.output(MagiColorScreen.SetColors(params: ee.params))
            self.output(UI.Show(MagiColorScreen()))
            
            self.reset()
        }
    }
    
    func handleDownloadCancelled(_: DownloadScreen.DownloadingCancelled) {
        output(UI.Hide(DownloadWaitingOverlay()))
        output(Downloading.Cancel())
        
        reset()
    }
    
    func handleDownloadFailed(_: Downloading.Failed) {
        output(UI.Hide(DownloadWaitingOverlay()))
        
        reset()
    }
    
    func handleDownloadProgress(_ event: Downloading.Progress) {
        output(DownloadWaitingOverlay.ShowProgress(current: event.current, total: event.total))
    }
}
