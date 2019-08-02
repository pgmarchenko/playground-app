//
//  FeatureFlow.swift
//  FeatureFlow
//
//  Created by Pavel Marchanka on 5/30/19.
//  Copyright © 2019 Pavel Marchenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// 
///
open class FeatureFlow {
    public init(record: Bool = false) {
        input
            .bind { [weak self] in self?.processInput($0) }
            .disposed(by: disposeBag)

        if record {
            output
                .bind { [weak self] action in
                    self?.commandsLog.append(action)
                }
                .disposed(by: disposeBag)
        }
        
        reset()
    }
    
    /**
     Send event to the flow to generate commands
     
     - Parameters:
     - event: Event to dispatch

     */
    public func dispatch(_ event: FeatureFlowEvent) {
        guard !outputIsProcessing else {
            fatalError("You should not use the flow object itself directly in the command handler. If needed, use async calls")
        }
        
        input.onNext(event)
    }
    
    /**
     Pass callback to react on flow command
     
     - Parameters:
        - handler: Callback to do reaction
     
     - Warning: You should not use the flow object itself directly in the handler. If needed, use async calls.
     */
    public func onCommand<Command: FeatureFlowCommand>(_ Command: Command.Type, _ handler: @escaping (Command) -> Void) {
        outputIsProcessing = true
        defer { outputIsProcessing = false }
        
        return onCommand(handler)
    }
    
    
    public func onAction<Action: FeatureFlowAction>(_ Action: Action.Type, _ handler: @escaping (Action) -> Void) {
        outputIsProcessing = true
        defer { outputIsProcessing = false }
        
        return onAction(handler)
    }
    
    // MARK: - для наследников
    
    open func reset() {
        removeAllChildFlows()
        removeHandlers()
    }
    
    @discardableResult
    public func addChildFlow(_ flow: FeatureFlow) -> FeatureFlow {
        childFlows.append(flow)
        
        flow.output
            .bind { [weak self] in self?.output($0) }
            .disposed(by: flow.disposeBag)
        
        return flow
    }
    
    public func output(_ command: FeatureFlowCommand) {
        self.output.onNext(command)
    }
    
    public func output(_ commands: [FeatureFlowCommand]) {
        commands.forEach(output)
    }

    public func output(_ commands: FeatureFlowCommand...) {
        output(commands)
    }
    
    /**
     
     
     - Parameters:
     - action: Output action type, for the handler
     - handler: Callback to do reaction.
     
     - Warning: You should not use the flow object itself directly in the handler. If needed, use async calls.
     */
    public func waitSingleEvent<Event: FeatureFlowEvent>(_ handler: @escaping (Event) -> Void) {
        return takeActions(count: 1, handler)
            .disposed(by: inputDisposeBag)
    }
    
    public func waitEvents<Event: FeatureFlowEvent>(_ handler: @escaping(Event) -> Void) {
        return takeActions(handler)
            .disposed(by: inputDisposeBag)
    }
    
    public func waitSingleAction<Action: FeatureFlowAction>(_ handler: @escaping (Action) -> Void) {
        return takeActions(count: 1, handler)
            .disposed(by: inputDisposeBag)
    }
    
    public func waitActions<Action: FeatureFlowAction>(_ handler: @escaping(Action) -> Void) {
        return takeActions(handler)
            .disposed(by: inputDisposeBag)
    }

    public func removeHandlers() {
        inputDisposeBag = DisposeBag()
    }
    
    public func removeAllChildFlows() {
        childFlows.removeAll()
    }
    
    public func removeFlow(_ flow: FeatureFlow) {
        childFlows.removeAll { $0 === flow }
    }
    
    @discardableResult
    public func popRecordedCommands() -> [FeatureFlowCommand] {
        defer { commandsLog.removeAll() }
        
        return commandsLog
    }

    public let disposeBag = DisposeBag()

    private let input = PublishSubject<FeatureFlowAction>()
    private let output = PublishSubject<FeatureFlowCommand>()

    private var childFlows = [FeatureFlow]()
    private var inputDisposeBag = DisposeBag()
    
    // debug helper
    private var outputIsProcessing = false
    
    private var commandsLog = [FeatureFlowCommand]()
}

public extension FeatureFlow {
    fileprivate func takeActions<Action: FeatureFlowAction>(count: Int? = nil, _ handler: @escaping (Action) -> Void) -> Disposable {
        
        let filteredInput = input
            .filter { $0 is Action }
        
        let trimmedInput: Observable<FeatureFlowAction> = {
            if let count = count {
                return filteredInput
                    .take(count)
            } else {
                return filteredInput
            }
        }()
        
        return trimmedInput
            .map { $0 as! Action }
            .subscribe(onNext: { a in
                handler(a)
            })
    }
    
    fileprivate func processInput(_ input: FeatureFlowAction) {
        childFlows.forEach { $0.input.onNext(input) }
    }
    
    fileprivate func processInput(_ handler: @escaping (FeatureFlowAction) -> Void) -> Disposable {
        return input.bind(onNext: handler)
    }
    
    fileprivate func onCommand<Command: FeatureFlowCommand>(_ handler: @escaping (Command) -> Void) {
        return output
            .filter { $0 is Command }
            .map { $0 as! Command }
            .subscribe(
                onNext: { a in
                    handler(a)
            },
                onDisposed: {
                    debugPrint("Disposed!")
            }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func onAction<Action: FeatureFlowAction>(_ handler: @escaping (Action) -> Void) {
        return Observable.merge(
                input.map{ $0 as FeatureFlowAction },
                output.map{ $0 as FeatureFlowAction }
            )
            .filter { $0 is Action }
            .map { $0 as! Action }
            .subscribe(
                onNext: { a in
                    handler(a)
            },
                onDisposed: {
                    debugPrint("Disposed!")
            }
            )
            .disposed(by: disposeBag)
    }
}

public extension FeatureFlow {
    struct Start: FeatureFlowEvent { public init() {} }
}

