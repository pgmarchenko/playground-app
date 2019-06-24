//
//  MagiColorSetModeFlow.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/9/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

public class MagiColorScreenFlow: FeatureFlow {
    public override func reset() {
        super.reset()
        
        waitSingleEvent(handleRedButtonTouched)
        waitEvents(handleTutorialTouched)
    }
}

private extension MagiColorScreenFlow {
    func handleRedButtonTouched(_ event: MagiColorScreen.RedButtonTouched) {
        output(MagiColorScreen.SetRedMode())
        
        waitSingleEvent(handleResetButtonTouched)
    }
    
    func handleResetButtonTouched(_ event: MagiColorScreen.ResetButtonTouched) {
        output(MagiColorScreen.SetWhiteMode())
        
        reset()
    }
    
    func handleTutorialTouched(_ event: MagiColorScreen.TutorialSwitcherTouched) {
        removeHandlers()
        
        output(MagiColorScreen.SetTutorialTitle("Tutorial mode!"))
        
        waitEvents(handleRedButtonTutorial)
        waitEvents(handleResetColorsButtonTutorial)
        
        waitSingleEvent(handleFinishTutorial)
    }
    
    func handleFinishTutorial(_ event: MagiColorScreen.TutorialSwitcherTouched) {
        output(MagiColorScreen.SetTutorialTitle(nil))
        
        reset()
    }
    
    func handleRedButtonTutorial(_ event: MagiColorScreen.RedButtonTouched) {
        output(MagiColorScreen.SetTutorialTitle("Will change background color to self color"))
    }
    
    func handleResetColorsButtonTutorial(_ event: MagiColorScreen.ResetButtonTouched) {
        output(MagiColorScreen.SetTutorialTitle("Will change colors back"))
    }
}
