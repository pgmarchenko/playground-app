//
//  AppDelegate.swift
//  PlaygroundApp
//
//  Created by Pavel Marchenko on 10/2/18.
//  Copyright © 2018 pgmarchenko. All rights reserved.
//

import UIKit

import UI
import App
import AppFlow
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let appFlow = AppFlow()
    let downloadService = DownloadService()
    let appDisposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootVC = MenuScreenViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        defer { appFlow.dispatch(DownloadScreen.DidAppear()) }
        
        rootVC.downloadScreen.rx.viewDidAppear
            .map { _ in DownloadScreen.DidAppear() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        rootVC.magiColorScreen.rx.viewDidAppear
            .map { _ in MagiColorScreen.DidAppear() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        rootVC.downloadScreen.onDownloadAndOpenClicked
            .map { _ in DownloadScreen.DownloadAndOpen() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        rootVC.downloadScreen.onCancelDownloadClicked
            .map { _ in DownloadScreen.DownloadingCancelled() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        
        downloadService.onProgress
            .map { Downloading.Progress(current: $0, total: $1) }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        downloadService.onSuccess
            .map { Downloading.Succeeded() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        downloadService.onError
            .map { _ in Downloading.Failed() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        
        appFlow.onCommand(DownloadWaitingOverlay.Show.self) { _ in
            rootVC.downloadScreen.showWaitingOverlay()
            rootVC.downloadScreen.showRetry(false)
            
            self.downloadService.download()
        }
        
        appFlow.onCommand(DownloadWaitingOverlay.Hide.self) { _ in
            rootVC.downloadScreen.showWaitingOverlay(false)
            self.downloadService.cancel()
        }
        
        appFlow.onCommand(DownloadWaitingOverlay.ShowProgress.self) { cmd in
            debugPrint("\(cmd.current) / \(cmd.total)")
        }
        
        appFlow.onCommand(MagiColorScreen.Show.self) { _ in
            rootVC.selectedIndex = 1
        }
        
        rootVC.magiColorScreen.onChangeBGColorClicked
            .map { _ in MagiColorScreen.RedButtonTouched() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        rootVC.magiColorScreen.onResetColorsClicked
            .map { _ in MagiColorScreen.ResetButtonTouched() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        rootVC.magiColorScreen.onTutorialClicked
            .map { _ in MagiColorScreen.TutorialSwitcherTouched() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        
        appFlow.onCommand(MagiColorScreen.SetRedMode.self) { _ in
            rootVC.magiColorScreen.fillWithButtonColor()
        }
        
        appFlow.onCommand(MagiColorScreen.SetWhiteMode.self) { _ in
            rootVC.magiColorScreen.resetColors()
        }
        
        appFlow.onCommand(MagiColorScreen.SetTutorialTitle.self) { cmd in
            rootVC.magiColorScreen.setTutorialText(cmd.title)
        }
        
        return true
    }
}

