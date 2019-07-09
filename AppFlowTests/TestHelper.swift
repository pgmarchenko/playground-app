//
//  Helper.swift
//  FeatureFlowTests
//
//  Created by Pavel Marchanka on 6/24/19.
//  Copyright © 2019 Pavel Marchanka. All rights reserved.
//

import Foundation
import RxSwift

import Quick
import Nimble

import AppFlow

public func beEqual(_ expectedValue: [FeatureFlowCommand]) -> Predicate<[FeatureFlowCommand]> {
    return Predicate.define("equal <\(stringify(expectedValue))>") { actualExpression, msg in
        guard let actualValue = try actualExpression.evaluate() else {
            return PredicateResult(
                status: .fail,
                message: msg.appendedBeNilHint()
            )
        }
        
        let matches = areEqual(lhs: expectedValue, other: actualValue)
        return PredicateResult(bool: matches, message: msg)
    }
}

func areEqual(lhs: [FeatureFlowCommand], other: [FeatureFlowCommand]) -> Bool {
    guard lhs.count == other.count else { return false }
    guard lhs.count > 0 else { return true }
    
    return !zip(lhs, other).contains { (arg) -> Bool in
        let (lhs, rhs) = arg
        let notEqual = lhs.asEquatable() != rhs.asEquatable()
        if notEqual {
            debugPrint("not equal items: \(lhs) \(rhs)")
        }
        
        return notEqual
    }
}

func == (lhs: Expectation<[FeatureFlowCommand]>, other: [FeatureFlowCommand]) {
    lhs.to(beEqual(other))
}


typealias ExpectationTuple = ([FeatureFlowEvent], [FeatureFlowCommand], FileString, UInt)

func expectFlow(_ flow: FeatureFlow, _ expectations: Any, resetFlowBeforeEach: Bool = true, file: FileString = #file, line: UInt = #line) {
    if resetFlowBeforeEach {
        beforeEach {
            flow.reset()
        }
    }
    
    if let expectations = expectations as? [Any] {
        guard let e = expectations.first else { return }
        
        switch e {
        case (let events, let commands, let expFile, let expLine) as ExpectationTuple:
            context("\(events)") {
                beforeEach {
                    flow.popRecordedCommands()
                    
                    events.forEach(flow.dispatch)
                }
                
                it("\(commands)") {
                    expect(flow.popRecordedCommands(), file: expFile, line: expLine) == commands
                }
                
                expectFlow(flow, Array(expectations.dropFirst()), resetFlowBeforeEach: false, file: expFile, line: expLine)
            }
        case let expectations as [[Any]]:
            expectations.forEach {
                debugPrint("Branch")
                expectFlow(flow, $0, resetFlowBeforeEach: false, file: file, line: line)
            }
        default:
            debugPrint("!!!Unknown expectation!!! \(e)")
        }
    }
    
}


func onEvents(
    _ events: [FeatureFlowEvent],
    commands: [FeatureFlowCommand],
    file: FileString = #file,
    line: UInt = #line
) -> ExpectationTuple {
    return (
        events,
        commands,
        file,
        line
    )
}

func branches(_ branches: Any...) -> [Any] {
    return branches
}
