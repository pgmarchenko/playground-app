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
        self.onChangeBGColorClicked.bind {
            self.fillWithButtonColor()
            }.disposed(by: disposer)
        
        self.onResetColorsClicked.bind {
            self.resetColors()
            }.disposed(by: disposer)
        
        self.onTutorialClicked.bind(disposing: disposer) { disposer, _ in
            self.updateToTutorialMode()
            self.assembleTutorialInteractions(with: disposer)
            }
        
        self.challengeMode.bind(disposing: disposer) { disposer, isEnabled in
            guard isEnabled else {
                assertionFailure("should not be called")
                return
            }
            self.updateToChallengeMode()
            self.assembleChallengeInteractions(with: disposer)
            }
    }
    
    public func assembleChallengeInteractions(with disposer: CompositeDisposable) {
        self.onChangeBGColorClicked.throttle(0.2, scheduler: MainScheduler.instance).bind {
            
            if arc4random_uniform(2) == 0 {
                self.setHidingLabelPositionTop()
            } else {
                self.setHidingLabelPositionBottom()
            }
            
            self.fillWithButtonColor()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.resetColors()
            }
            }.disposed(by: disposer)
        
        self.challengeMode.bind(disposing: disposer) { disposer, isEnabled in
            guard !isEnabled else {
                assertionFailure("should not be called")
                return
            }
            self.updateToMainMode()
            self.assembleMainInteractions(with: disposer)
            }
        
        self.onTutorialClicked.bind(disposing: disposer) { disposer, _ in
            self.updateToTutorialMode()
            self.assembleTutorialInteractions(with: disposer)
        }
    }
    
    public func assembleTutorialInteractions(with disposer: CompositeDisposable) {
        self.onChangeBGColorClicked.bind {
            self.setTutorialText("Will change background color to self color")
            }.disposed(by: disposer)
        
        self.onResetColorsClicked.bind {
            self.setTutorialText("Will change colors back")
            }.disposed(by: disposer)
        
        self.onTutorialClicked.bind(disposing: disposer) { disposer, _ in
            self.updateToMainMode()
            self.assembleMainInteractions(with: disposer)
        }
    }
}
