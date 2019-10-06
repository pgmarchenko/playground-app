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

protocol Callable {
    func call(_ e: FeatureFlowEvent) -> FeatureFlowEvent?
}

class Func<Input: FeatureFlowEvent>: Callable {
    
    init(_ f: @escaping (Input)->FeatureFlowEvent) {
        self.f = f
        self.input = Input.self
    }
    
    func call(_ e: FeatureFlowEvent) -> FeatureFlowEvent? {
        if let input = e as? Input {
            return f(input)
        } else {
            return nil
        }
    }
    
    let input: Input.Type
    let f: (Input)->FeatureFlowEvent
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
    
    func addEventMapper<Event: FeatureFlowEvent, Extended: FeatureFlowEvent>(_ e: Event.Type, mapper: @escaping (Event)->Extended) {
        mappers.append(Func(mapper))
    }
    
    private func assembleMenuScreenViewController() {
        Observable.merge(
            rootVC.downloadScreen.events,
            rootVC.magiColorScreen.events
        )
            .map(mapEvents)
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
    
    private func mapEvents(_ e: FeatureFlowEvent) -> FeatureFlowEvent {
        for f in self.mappers {
            if let res = f.call(e) {
                return res
            }
        }
        
        return e
    }
    
    private var window: UIWindow?
    private let rootVC = MenuScreenViewController()
    private let disposeBag = DisposeBag()
    
    private let input = PublishSubject<FeatureFlowCommand>()
    
    private var mappers: [Callable] = []
}
