//
//  AppDelegate.swift
//  PlaygroundApp
//
//  Created by Pavel Marchenko on 10/2/18.
//  Copyright © 2018 pgmarchenko. All rights reserved.
//

import UIKit

import RxSwift

import UI
import App
import AppFlow
import AppEntities


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    let appFlow = AppFlow()
    let router = Router()
    let downloadService = DownloadService()
    let appDisposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        router.attach(to: window)
        
        appFlow.onAnyCommand(router.dispatchCommand)
        appFlow.onAnyCommand(downloadService.dispatchCommand)
        
        Observable.merge(
            router.events,
            downloadService.events
        )
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        appFlow.onCommand(DownloadWaitingOverlay.ShowProgress.self) { cmd in
            debugPrint("\(cmd.current) / \(cmd.total)")
        }
        
        return true
    }
}

