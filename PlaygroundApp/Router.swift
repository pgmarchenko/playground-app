//
//  Router.swift
//  PlaygroundApp
//
//  Created by Pavel Marchanka on 8/12/19.
//  Copyright © 2019 pgmarchenko. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

import UI
import AppEntities


protocol FeatureFlowEventsGenerator {
    var events: PublishSubject<FeatureFlowEvent> { get }
}

protocol FeatureFlowCommandsDispatcher {
    func dispatchCommand(_ cmd: FeatureFlowCommand)
}


class Router: FeatureFlowEventsGenerator, FeatureFlowCommandsDispatcher {
    let events = PublishSubject<FeatureFlowEvent>()
    
    init(record: Bool = false) {
        
    }
    
    func attach(to window: UIWindow?) {
        self.window = window
        
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        assembleMenuScreenViewController()
    }
    
    func dispatchCommand(_ cmd: FeatureFlowCommand) {
        switch cmd {
        case is UI.Show<MagiColorScreen>:
            rootVC.selectedIndex = 1
        default:
            rootVC.downloadScreen.dispatchCommand(cmd)
            rootVC.magiColorScreen.dispatchCommand(cmd)
        }
    }
    
    private func assembleMenuScreenViewController() {
        rootVC.downloadScreen.events
            .bind(to: events)
            .disposed(by: disposeBag)
        
        rootVC.magiColorScreen.events
            .bind(to: events)
            .disposed(by: disposeBag)
        
        rootVC.downloadScreen.rx.viewWillAppear
            .map { _ in UI.WillAppear(DownloadScreen()) }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        rootVC.downloadScreen.rx.viewDidAppear
            .map { _ in UI.DidAppear(DownloadScreen()) }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        rootVC.magiColorScreen.rx.viewWillAppear
            .map { _ in UI.WillAppear(MagiColorScreen()) }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        rootVC.magiColorScreen.rx.viewDidAppear
            .map { _ in UI.DidAppear(MagiColorScreen()) }
            .bind(to: events)
            .disposed(by: disposeBag)
    }
    
    private var window: UIWindow?
    private let rootVC = MenuScreenViewController()
    private let disposeBag = DisposeBag()
    
    private let input = PublishSubject<FeatureFlowCommand>()
}
