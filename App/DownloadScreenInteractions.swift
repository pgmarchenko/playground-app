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

public func delayOnMain(_ delay: Double, closure:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public class DownloadService {
    public let onProgress = PublishSubject<(current: Double, total: Double)>()
    public let onSuccess = PublishSubject<()>()
    public let onError = PublishSubject<Error>()
    
    public struct DownloadUnknownError: Error { }
    
    public func download() {
        let success = arc4random_uniform(2) == 0
        
        delayOnMain(1) {
            if success {
                self.onSuccess.onNext(())
            } else {
                self.onError.onNext(DownloadUnknownError())
            }
        }
    }
    
    public func cancel() {
        
    }
}

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
