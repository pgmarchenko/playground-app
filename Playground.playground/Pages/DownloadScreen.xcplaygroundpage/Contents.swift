import PlaygroundSupport
import Foundation
import UIKit

import App
import UI
import RxSwift

protocol Event {
}
struct ConcreteEventA: Event {
}
struct ConcreteEventB: Event {
}

protocol Callable {
    func call(_ e: Event) -> Event?
}

class Func<Input: Event>: Callable {
    
    init(_ f: @escaping (Input)->Event) {
        self.f = f
        self.input = Input.self
    }
    
    func call(_ e: Event) -> Event? {
        if let input = e as? Input {
            return f(input)
        } else {
            return nil
        }
    }
    
    let input: Input.Type
    let f: (Input)->Event
}

let funcs: [Callable] = [
    Func(mapAB),
    Func(mapBA)
]

func mapAB(_ e: ConcreteEventA) -> ConcreteEventB {
    debugPrint("CALLL A!!!")
    return ConcreteEventB()
}

func mapBA(_ e: ConcreteEventB) -> ConcreteEventA {
    debugPrint("CALLL B!!!")
    return ConcreteEventA()
}

funcs.forEach { f in
    f.call(ConcreteEventB())
}

//
//protocol Event {
//    var id: String { get }
//}
//class ConcreteEventA: Event {
//    var id: String { return "ConcreteEventA" }
//}
//class ConcreteEventB: Event {
//    var id: String { return "ConcreteEventB" }
//}
//func generalMap<T: Event, U: Event>(_ transform: @escaping (T) -> U) -> (Event) -> Event {
//    return { e in
//        transform(e as! T) as! Event
//    }
//}
//func mapConcreteEventA(_ e: ConcreteEventA) -> ConcreteEventB {
//    return ConcreteEventB()
//}
//func mapConcreteEventB(_ e: ConcreteEventB) -> ConcreteEventA {
//    return ConcreteEventA()
//}
//let dict: [HashableType<Event>: (Event) -> (Event)] = [
//    HashableType(ConcreteEventA.self): generalMap(mapConcreteEventA),
//    HashableType(ConcreteEventB.self): generalMap(mapConcreteEventB)
//]
//func transform(input: Event) -> Event {
//    let function = dict[input.self]!
//    return function(input)
//}
//transform(input: ConcreteEventA())
//transform(input: ConcreteEventB())



//protocol Event {
//}
//
//struct ConcreteEventA: Event {}
//struct ConcreteEventB: Event {}
//
//let pipe = PublishSubject<Event>()
//
//func map(_ e: ConcreteEventA) -> ConcreteEventB {
//    return ConcreteEventB()
//}
//
//pipe
//    .map { e in
//        if let eA = e as? ConcreteEventA {
//            return map(eA)
//        } else {
//            return e
//        }
//    }
//    .bind { e in
//        debugPrint(e)
//    }
//
//pipe.onNext(ConcreteEventA())

//let vc = DownloadScreenViewController()
//
//PlaygroundPage.current.liveView = vc
