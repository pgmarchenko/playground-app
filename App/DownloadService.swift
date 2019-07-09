//
//  DownloadService.swift
//  App
//
//  Created by Pavel Marchanka on 7/10/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

public func delayOnMain(_ delay: Double, closure:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public class DownloadService {
    public let onProgress = PublishSubject<(current: Double, total: Double)>()
    public let onSuccess = PublishSubject<()>()
    public let onError = PublishSubject<Error>()
    
    public struct DownloadUnknownError: Error { }
    
    public init() { }
    
    public func download() {
        let success = arc4random_uniform(2) == 0
        let responseTime = Double(arc4random_uniform(3) + 1)
        
        if success {
            let total = responseTime * 100
            
            Observable<Int>.interval(.milliseconds(10), scheduler: MainScheduler.instance)
                .take(Int(total))
                .bind { interval in
                    self.onProgress.onNext((Double(interval), total))
                }
                .disposed(by: progressDisposeBag)
        }
        
        delayOnMain(responseTime) {
            if success {
                self.onSuccess.onNext(())
            } else {
                self.onError.onNext(DownloadUnknownError())
            }
            
            self.progressDisposeBag = DisposeBag()
        }
    }
    
    public func cancel() {
        progressDisposeBag = DisposeBag()
    }
    
    private var progressDisposeBag = DisposeBag()
}
