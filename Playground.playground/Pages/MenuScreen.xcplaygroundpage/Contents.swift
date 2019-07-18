//: [Previous](@previous)

import PlaygroundSupport
import Foundation
import DeviceScreenViewController

import App
import UI

class Foo {
    
    func print(_ v: Int) {
        
    }
    
    func print(_ v: String) {
        
    }
}

let f = Foo()

let fa = f as AnyObject

fa.print?(10)
