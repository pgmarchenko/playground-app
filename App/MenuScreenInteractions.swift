//
//  MenuScreenInteractions.swift
//  App
//
//  Created by Pavel Marchenko on 10/4/18.
//  Copyright © 2018 pgmarchenko. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import UI

extension MenuScreenViewController {
    public func assembleInterations(with topDisposer: CompositeDisposable = .init()) {
        self.magiColorScreen.assembleMainInteractions()
        
        let thirdScreenInteractor = self.thirdTabScreen.assembleInteractions()
        thirdScreenInteractor.onOpenFirstTab.bind {
            self.selectedIndex = 0
        }.disposed(by: topDisposer)

        let downloadInteractor = self.downloadScreen.assembleInteractions()
        downloadInteractor.onOpen.bind {
            self.selectedIndex = 1
        }.disposed(by: topDisposer)
        
        self.rx.didSelect.bind { vc in
            if vc !== self.thirdTabScreen {
                thirdScreenInteractor.onDeactivate.onNext(())
            }
        }.disposed(by: topDisposer)
    }
}
