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
        
        waitEvents(handleRedButtonTouched)
        waitEvents(handleResetButtonTouched)
        waitEvents(handleTutorialTouched)
    }
}

private extension MagiColorScreenFlow {
    func handleRedButtonTouched(_: MagiColorScreen.RedButtonTouched) {
        output(MagiColorScreen.SetRedMode())
    }
    
    func handleResetButtonTouched(_: MagiColorScreen.ResetButtonTouched) {
        output(MagiColorScreen.SetWhiteMode())
    }
    
    func handleTutorialTouched(_: MagiColorScreen.TutorialSwitcherTouched) {
        removeHandlers()
        
        output(MagiColorScreen.SetTutorialTitle("Tutorial mode!"))
        
        waitEvents(handleRedButtonTutorial)
        waitEvents(handleResetColorsButtonTutorial)
        
        waitSingleEvent(handleFinishTutorial)
    }
    
    func handleFinishTutorial(_: MagiColorScreen.TutorialSwitcherTouched) {
        output(MagiColorScreen.SetTutorialTitle(nil))
        
        reset()
    }
    
    func handleRedButtonTutorial(_: MagiColorScreen.RedButtonTouched) {
        output(MagiColorScreen.SetTutorialTitle("Will change background color to self color"))
    }
    
    func handleResetColorsButtonTutorial(_: MagiColorScreen.ResetButtonTouched) {
        output(MagiColorScreen.SetTutorialTitle("Will change colors back"))
    }
}
