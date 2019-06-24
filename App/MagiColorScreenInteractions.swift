//
//  MagiColorScreenInteractions.swift
//  App
//
//  Created by Pavel Marchenko on 10/4/18.
//  Copyright © 2018 pgmarchenko. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import UI
import Utilities

extension MagiColorScreenViewController {
    public func assembleMainInteractions(with disposer: CompositeDisposable = CompositeDisposable()) {
//        self.onChangeBGColorClicked.bind {
//            self.fillWithButtonColor()
//            }.disposed(by: disposer)
//        
//        self.onResetColorsClicked.bind {
//            self.resetColors()
//            }.disposed(by: disposer)
//        
//        self.onTutorialClicked.bind(disposing: disposer) { disposer, _ in
//            self.setTutorialText("Tutorial mode!")
//            self.assembleTutorialInteractions(with: disposer)
//        }
    }
    
    public func assembleTutorialInteractions(with disposer: CompositeDisposable) {
        self.onChangeBGColorClicked.bind {
            self.setTutorialText("Will change background color to self color")
            }.disposed(by: disposer)
        
        self.onResetColorsClicked.bind {
            self.setTutorialText("Will change colors back")
            }.disposed(by: disposer)
        
        self.onTutorialClicked.bind(disposing: disposer) { disposer, _ in
            self.setTutorialText(nil)
            self.assembleMainInteractions(with: disposer)
        }
    }
}
