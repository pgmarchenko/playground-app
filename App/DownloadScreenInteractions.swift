//
//  DownloadScreenInteractions.swift
//  App
//
//  Created by Pavel Marchenko on 10/4/18.
//  Copyright © 2018 pgmarchenko. No rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import UI
import Utilities

extension DownloadScreenViewController {
    public func assembleInteractions(with disposer: CompositeDisposable = .init()) {
        self.onDownloadAndOpenClicked.bind { _ in
            let disposer = CompositeDisposable()
            
            self.showWaitingOverlay()
            
            self.onCancelLongOperationClicked.bind(disposing: disposer) { _, _ in
                self.showWaitingOverlay(false)
            }
        }.disposed(by: disposer)
    }
}
