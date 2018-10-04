//
//  RxSwiftBindDisposing.swift
//  Utilities
//
//  Created by Pavel Marchenko on 10/4/18.
//  Copyright © 2018 pgmarchenko. No rights reserved.
//

import Foundation

import RxSwift
import RxCocoa


extension Disposable {
    public func disposed(by cd: CompositeDisposable) {
        let key = cd.insert(self)
        
        assert(key != nil)
    }
}

extension UIControl {
    public func onTap(_ callback: @escaping () -> Void) -> Disposable {
        return self.rx.controlEvent(.touchUpInside).bind(onNext: callback)
    }
    
    public func onTap(disposing cd: CompositeDisposable, callback: @escaping (CompositeDisposable) -> Void) {
        self.rx.controlEvent(.touchUpInside)
            .bind(disposing: cd, onNext: { newCD, _ in
                callback(newCD)
            })
    }
}

extension ObservableType {
    func reset(_ cd: CompositeDisposable) -> RxSwift.Observable<Self.E> {
        return self
            .do(onNext: { _ in
                cd.dispose()
            })
    }
    
    public func bind(disposing cd: CompositeDisposable, onNext: @escaping (CompositeDisposable, Self.E) -> Void) {
        self.do(onNext: curry(onNext)(CompositeDisposable()))
            .reset(cd)
            .bind(onNext: { _ in })
            .disposed(by: cd)
    }
}
