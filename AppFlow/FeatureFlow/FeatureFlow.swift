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
import AppEntities

extension PublishSubject {
    public func takeActions<Action: FeatureFlowAction>(count: Int? = nil, _ handler: @escaping (Action) -> Void) -> Disposable {
        
        let filteredInput = self
            .debug()
            .filter { $0 is Action }
        
        let trimmedInput: Observable<Element> = {
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
}

public class FeatureFlowPipe<Action: FeatureFlowAction> {
    
    private let impl = PublishSubject<Action>()
}


public class FeatureFlowEngine {
    
    public init(record: Bool = false) {
        if record {
            output
                .bind { [weak self] action in
                    self?.commandsLog.append(action)
                }
                .disposed(by: disposeBag)
        }
    }

    
    let input = PublishSubject<FeatureFlowEvent>()
    let output = PublishSubject<FeatureFlowCommand>()
    
    var inputDisposeBag = DisposeBag()
    
    // debug helper
    var outputIsProcessing = false
    
    var commandsLog = [FeatureFlowCommand]()
    
    let disposeBag = DisposeBag()
}

public protocol FeatureFlowEngineDriven {
    
    var flowEngine: FeatureFlowEngine { get }
}

extension FeatureFlowEngineDriven {
    /**
     Send event to the flow to generate commands
     
     - Parameters:
     - event: Event to dispatch
     
     */
    public func dispatch(_ event: FeatureFlowEvent) {
        guard !flowEngine.outputIsProcessing else {
            fatalError("You should not use the flow object itself directly in the command handler. If needed, use async calls")
        }
        
        flowEngine.input.onNext(event)
    }
    
    /**
     Pass callback to react on flow command
     
     - Parameters:
     - handler: Callback to do reaction
     
     - Warning: You should not use the flow object itself directly in the handler. If needed, use async calls.
     */
    public func onCommand<Command: FeatureFlowCommand>(_ Command: Command.Type, _ handler: @escaping (Command) -> Void) {
        flowEngine.outputIsProcessing = true
        defer { flowEngine.outputIsProcessing = false }
        
        return onCommand(handler)
    }
    
    public func onAnyCommand(_ handler: @escaping (FeatureFlowCommand) -> Void) {
        flowEngine.outputIsProcessing = true
        defer { flowEngine.outputIsProcessing = false }
        
        flowEngine.output
            .subscribe(
                onNext: { a in
                    handler(a)
            },
                onDisposed: {
                    debugPrint("Disposed!")
            }
            )
            .disposed(by: flowEngine.disposeBag)
    }
}

extension FeatureFlowEngineDriven {
    public func output(_ command: FeatureFlowCommand) {
        self.flowEngine.output.onNext(command)
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
        return flowEngine.input.takeActions(count: 1, handler)
            .disposed(by: flowEngine.inputDisposeBag)
    }
    
    public func waitEvents<Event: FeatureFlowEvent>(_ handler: @escaping(Event) -> Void) {
        return flowEngine.input.takeActions(handler)
            .disposed(by: flowEngine.inputDisposeBag)
    }
    
    public func removeHandlers() {
        flowEngine.inputDisposeBag = DisposeBag()
    }
    
    @discardableResult
    public func popRecordedCommands() -> [FeatureFlowCommand] {
        defer { flowEngine.commandsLog.removeAll() }
        
        return flowEngine.commandsLog
    }
}

extension FeatureFlowEngineDriven {
    fileprivate func processInput(_ handler: @escaping (FeatureFlowEvent) -> Void) -> Disposable {
        return flowEngine.input.bind(onNext: handler)
    }
    
    fileprivate func onCommand<Action: FeatureFlowCommand>(_ handler: @escaping (Action) -> Void) {
        return flowEngine.output
            .debug()
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
            .disposed(by: flowEngine.disposeBag)
    }
}

/// 
///
open class FeatureFlow: FeatureFlowEngineDriven {
    public init(record: Bool = false) {
        flowEngine = FeatureFlowEngine(record: record)
        
        flowEngine
            .input
            .bind { [weak self] in self?.processInput($0) }
            .disposed(by: disposeBag)
        
        reset()
    }
    
    // MARK: - для наследников
    
    open func reset() {
        removeAllChildFlows()
        removeHandlers()
    }
    
    @discardableResult
    public func addChildFlow(_ flow: FeatureFlow) -> FeatureFlow {
        childFlows.append(flow)
        
        flow.flowEngine.output
            .bind { [weak self] in self?.output($0) }
            .disposed(by: flow.disposeBag)
        
        return flow
    }
    
    public func removeFlow(_ flow: FeatureFlow) {
        childFlows.removeAll { $0 === flow }
    }
    
    public func removeAllChildFlows() {
        childFlows.removeAll()
    }

    public let disposeBag = DisposeBag()

    let finished = PublishSubject<FeatureFlowEvent>()

    private var childFlows = [FeatureFlow]()
    
    public let flowEngine: FeatureFlowEngine
}

extension FeatureFlow {
    fileprivate func processInput(_ input: FeatureFlowEvent) {
        childFlows.forEach { $0.dispatch(input) }
    }
}
