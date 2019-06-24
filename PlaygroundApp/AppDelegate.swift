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
    let appDisposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootVC = MenuScreenViewController()
        rootVC.assembleInterations()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        defer { appFlow.dispatch(DownloadScreen.Showed()) }
        
        rootVC.rx.didSelect
            .bind { vc in
                switch vc {
                case _ as DownloadScreenViewController:
                    self.appFlow.dispatch(DownloadScreen.Showed())
                case _ as MagiColorScreenViewController:
                    self.appFlow.dispatch(MagiColorScreen.Showed())
                default:
                    break
                }
            }.disposed(by: appDisposeBag)
        
        rootVC.downloadScreen.onDownloadAndOpenClicked
            .map { _ in DownloadScreen.DownloadAndOpen() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        rootVC.downloadScreen.onCancelDownloadClicked
            .map { _ in DownloadScreen.DownloadingCancelled() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        appFlow.onCommand(DownloadWaitingOverlay.Show.self) { cmd in
            rootVC.downloadScreen.showWaitingOverlay()
            rootVC.downloadScreen.showRetry(false)
        }
        
        appFlow.onCommand(DownloadWaitingOverlay.Hide.self) { cmd in
            rootVC.downloadScreen.showWaitingOverlay(false)
        }
        
        
        rootVC.magiColorScreen.onChangeBGColorClicked
            .map { _ in MagiColorScreen.RedButtonTouched() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        rootVC.magiColorScreen.onResetColorsClicked
            .map { _ in MagiColorScreen.ResetButtonTouched() }
            .bind(onNext: appFlow.dispatch)
            .disposed(by: appDisposeBag)
        
        appFlow.onCommand(MagiColorScreen.SetRedMode.self) { cmd in
            rootVC.magiColorScreen.fillWithButtonColor()
        }
        
        appFlow.onCommand(MagiColorScreen.SetWhiteMode.self) { cmd in
            rootVC.magiColorScreen.resetColors()
        }
//        let downloadInteractor = rootVC.downloadScreen.assembleInteractions()
        
//        downloadInteractor.onOpen.bind {
//            self.selectedIndex = 1
//            }.disposed(by: topDisposer)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

