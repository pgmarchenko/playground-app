//
//  MagiColorSetModeFlow.swift
//  AppFlow
//
//  Created by Pavel Marchanka on 7/9/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

import AppEntities

public class MagiColorScreenFlow: FeatureFlow {
    public override func reset() {
        super.reset()
        
        waitEvents(handleRedButtonTouched)
        waitEvents(handleResetButtonTouched)
        waitEvents(handleTutorialTouched)
    }
}

private extension MagiColorScreenFlow {
    func handleRedButtonTouched(_: MagiColorScreen.ColorButtonTouched) {
        output(MagiColorScreen.SetColorMode())
    }
    
    func handleResetButtonTouched(_: MagiColorScreen.ResetButtonTouched) {
        output(MagiColorScreen.SetDefaultMode())
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
    
    func handleRedButtonTutorial(_: MagiColorScreen.ColorButtonTouched) {
        output(MagiColorScreen.SetTutorialTitle("Will change background color to self color"))
    }
    
    func handleResetColorsButtonTutorial(_: MagiColorScreen.ResetButtonTouched) {
        output(MagiColorScreen.SetTutorialTitle("Will change colors back"))
    }
}
