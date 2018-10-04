//
//  Curry.swift
//  Utilities
//
//  Created by Pavel Marchenko on 10/4/18.
//  Copyright © 2018 pgmarchenko. No rights reserved.
//

import Foundation

public func curry<A>(_ function: @escaping (A) -> Void) -> (A) -> (() -> Void) {
    return { (a: A) -> () -> Void in
        return {
            function(a)
        }
    }
}

public func curry<A, B>(_ function: @escaping (A) -> B) -> (A) -> B {
    return { (a: A) -> B in function(a) }
}

public func curry<A, B, C>(_ function: @escaping ((A, B)) -> C) -> (A) -> (B) -> C {
    return { (a: A) -> (B) -> C in { (b: B) -> C in function((a, b)) } }
}

public func curry<A, B, C, D>(_ function: @escaping ((A, B, C)) -> D) -> (A) -> (B) -> (C) -> D {
    return { (a: A) -> (B) -> (C) -> D in { (b: B) -> (C) -> D in { (c: C) -> D in function((a, b, c)) } } }
}
