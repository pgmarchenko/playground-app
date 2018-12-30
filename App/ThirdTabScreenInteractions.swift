import Foundation

import RxSwift
import RxCocoa

import UI

public class ThirdTabScreenInteractor {
    public let onOpenFirstTab = PublishSubject<()>()
    public let onDeactivate = PublishSubject<()>()
}

extension ThirdTabScreenViewController {

    @discardableResult
    public func assembleInteractions(with disposer: CompositeDisposable = CompositeDisposable()) -> ThirdTabScreenInteractor {
        
        let interactor = ThirdTabScreenInteractor()

        onFarewellClicked.bind { _ in
            self.setLabelText("Прощай")
            interactor.onOpenFirstTab.onNext(())
            }.disposed(by: disposer)
        
        onGoodbyeClicked.bind { _ in
            self.setLabelText("До встречи")
            interactor.onOpenFirstTab.onNext(())
            }.disposed(by: disposer)
        
        interactor.onDeactivate.bind {
            self.setLabelText("ушёл не прощаясь")
            }.disposed(by: disposer)
        
        NotificationCenter.default.rx.notification(.UIApplicationDidEnterBackground).subscribe(onNext: { _ in
            self.setLabelText("где-то тут")
            }).disposed(by: disposer)
        
        return interactor
    }
}
