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
import AppEntities

public func delayOnMain(_ delay: Double, closure:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public class DownloadService {
    public let events = PublishSubject<FeatureFlowEvent>()
    
    public func dispatchCommand(_ cmd: FeatureFlowCommand) {
        switch cmd {
        case is Downloading.Start:
            download()
        case is Downloading.Cancel:
            cancel()
        default:
            break
        }
    }
    
    public struct DownloadUnknownError: Error { }
    
    public init() {
    }
    
    private var progressDisposeBag = DisposeBag()
}


extension DownloadService {
    func download() {
        let success = arc4random_uniform(2) == 0
        let responseTime = Double(arc4random_uniform(3) + 1)
        
        if success {
            let total = responseTime * 100
            
            Observable<Int>.interval(.milliseconds(10), scheduler: MainScheduler.instance)
                .take(Int(total))
                .bind { interval in
                    self.events.onNext(Downloading.Progress(current: Double(interval), total: total))
                }
                .disposed(by: progressDisposeBag)
        }
        
        delayOnMain(responseTime) {
            if success {
                self.events.onNext(Downloading.Succeeded())
            } else {
                self.events.onNext(Downloading.Failed())
            }
            
            self.progressDisposeBag = DisposeBag()
        }
    }
    
    func cancel() {
        progressDisposeBag = DisposeBag()
    }
}
