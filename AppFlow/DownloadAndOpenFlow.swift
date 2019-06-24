//
//  DownloadScreenFlow.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 6/22/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public enum DownloadScreen {}

public extension DownloadScreen {
    struct Showed: FeatureFlowEvent { public init() {} }
    
    struct DownloadAndOpen: FeatureFlowEvent { public init() {} }
    struct OpenForVideo: FeatureFlowEvent { public init() {} }
    
    struct DownloadingCancelled: FeatureFlowEvent { public init() {} }
}

public enum MagiColorScreen {}

public extension MagiColorScreen {
    struct Showed: FeatureFlowEvent { public init() {} }
    
    struct RedButtonTouched: FeatureFlowEvent { public init() {} }
    struct ResetButtonTouched: FeatureFlowEvent { public init() {} }
    
    struct TutorialSwitcherTouched: FeatureFlowEvent { public init() {} }
}

public class DownloadAndOpenFlow: FeatureFlow {
    public override init(record: Bool = true) {
        super.init(record: record)
        
        assembleInitialHandlers()
    }
}

private extension DownloadAndOpenFlow {
    func assembleInitialHandlers() {
        waitSingleEvent(handleDownloadAndOpen)
    }
    
    func handleDownloadAndOpen(_ it: DownloadScreen.DownloadAndOpen) {
        output(DownloadWaitingOverlay.Show())
        
        removeHandlers()
        waitSingleEvent(handleDownloadCancelled)
    }
    
    func handleDownloadCancelled(_ it: DownloadScreen.DownloadingCancelled) {
        output(DownloadWaitingOverlay.Hide())
        
        removeHandlers()
        assembleInitialHandlers()
    }
}


public enum DownloadWaitingOverlay { }

public extension DownloadWaitingOverlay {
    struct Show: FeatureFlowCommand, Equatable { public init() {} }
    
    struct ShowRetry: FeatureFlowCommand, Equatable { public init() {} }
    struct HideRetry: FeatureFlowCommand, Equatable { public init() {} }
    
    struct Hide: FeatureFlowCommand, Equatable { public init() {} }
}


public extension MagiColorScreen {
    struct SetRedMode: FeatureFlowCommand, Equatable { public init() {} }
    struct SetWhiteMode: FeatureFlowCommand, Equatable { public init() {} }
    
    struct SetTutorialTitle: FeatureFlowCommand, Equatable {
        public let title: String?
        
        public init(_ title: String?) {
            self.title = title
        }
    }
}
