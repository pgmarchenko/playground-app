//: [Previous](@previous)

import PlaygroundSupport
import Foundation
import UIKit

import RxSwift
import RxCocoa

import Utilities


let vc = MagiColorScreenViewController()

func assembleMainInteractions(with disposer: CompositeDisposable = CompositeDisposable()) {
    vc.onChangeBGColorClicked.bind {
        vc.fillWithButtonColor()
    }.disposed(by: disposer)
    
    vc.onResetColorsClicked.bind {
        vc.resetColors()
    }.disposed(by: disposer)
    
    vc.onTutorialClicked.bind(disposing: disposer) { disposer, _ in
        vc.setTutorialText("Tutorial mode!")
        assembleTutorialInteractions(with: disposer)
    }
}

func assembleTutorialInteractions(with disposer: CompositeDisposable) {
    vc.onChangeBGColorClicked.bind {
        vc.setTutorialText("Will change background color to self color")
    }.disposed(by: disposer)
    
    vc.onResetColorsClicked.bind {
        vc.setTutorialText("Will change colors back")
    }.disposed(by: disposer)
    
    vc.onTutorialClicked.bind(disposing: disposer) { disposer, _ in
        vc.setTutorialText(nil)
        assembleMainInteractions(with: disposer)
    }
}

assembleMainInteractions()

PlaygroundPage.current.liveView = vc
