//
//  DownloadScreenFlow.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 6/22/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public class DownloadAndOpenFlow: FeatureFlow {
    public override func reset() {
        super.reset()
        
        waitSingleEvent(handleDownloadAndOpen)
    }
}

private extension DownloadAndOpenFlow {
    func handleDownloadAndOpen(_: DownloadScreen.DownloadAndOpen) {
        output(DownloadWaitingOverlay.Show())
        output(Downloading.Start())
        
        removeHandlers()
        waitEvents(handleDownloadProgress)
        waitSingleEvent(handleDownloadCancelled)
        waitSingleEvent(handleDownloadFailed)
        
        waitSingleEvent { (event: Downloading.Succeeded) in
            self.output(DownloadWaitingOverlay.Hide())
            self.output(MagiColorScreen.Show())
            
            self.reset()
        }
    }
    
    func handleDownloadCancelled(_: DownloadScreen.DownloadingCancelled) {
        output(DownloadWaitingOverlay.Hide())
        output(Downloading.Cancel())
        
        reset()
    }
    
    func handleDownloadFailed(_: Downloading.Failed) {
        output(DownloadWaitingOverlay.Hide())
        
        reset()
    }
    
    func handleDownloadProgress(_ event: Downloading.Progress) {
        output(DownloadWaitingOverlay.ShowProgress(current: event.current, total: event.total))
    }
}
