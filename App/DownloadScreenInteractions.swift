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


public class DownloadScreenInteractor {
    public let onOpen = PublishSubject<()>()
    
    
}

extension DownloadScreenViewController {
    @discardableResult
    public func assembleInteractions(with topDisposer: CompositeDisposable = .init()) -> DownloadScreenInteractor {
        let interactor = DownloadScreenInteractor()
        
        self.onDownloadAndOpenClicked.bind { _ in
            let downloadDisposer = CompositeDisposable()
            let downloadService = DownloadService()
            
            downloadService.download()
            
            self.showWaitingOverlay()
            self.showRetry(false)
            
            self.onCancelDownloadClicked.bind(disposing: downloadDisposer) { _, _ in
                downloadService.cancel()
                self.showWaitingOverlay(false)
            }
            
            self.onRetryDownloadClicked.bind {
                downloadService.download()
                self.showRetry(false)
            }.disposed(by: downloadDisposer)

            downloadService.onSuccess.bind(disposing: downloadDisposer) { disposer, _ in
                interactor.onOpen.onNext(())
                self.showWaitingOverlay(false)
            }
            
            downloadService.onError.bind { error in
                self.showRetry(true)
            }.disposed(by: downloadDisposer)
            
        }.disposed(by: topDisposer)
        
        return interactor
    }
}
