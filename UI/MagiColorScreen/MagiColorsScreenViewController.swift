import Foundation
import UIKit

import RxSwift
import RxCocoa

import AppEntities
import Utilities


public class MagiColorScreenViewController: UIViewController {
    public let events = PublishSubject<FeatureFlowEvent>()
    
    public func dispatchCommand(_ cmd: FeatureFlowCommand) {
        switch cmd {
        case is MagiColorScreen.SetRedMode:
            fillWithButtonColor()
        case is MagiColorScreen.SetWhiteMode:
            resetColors()
        case let cmd as MagiColorScreen.SetTutorialTitle:
            setTutorialText(cmd.title)
        default:
            break
        }
    }

    let mainView = MagiColorScreenView()
    let disposeBag = DisposeBag()
}

extension MagiColorScreenViewController {
    public override func loadView() {
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.changeBGColorButton.rx.controlEvent(.touchUpInside)
            .map { _ in MagiColorScreen.RedButtonTouched() }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        mainView.resetColorsButton.rx.controlEvent(.touchUpInside)
            .map { _ in MagiColorScreen.ResetButtonTouched() }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        mainView.tutorialButton.rx.controlEvent(.touchUpInside)
            .map { _ in MagiColorScreen.TutorialSwitcherTouched() }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        resetColors()
    }
}

extension MagiColorScreenViewController {
    func fillWithButtonColor() {
        mainView.backgroundColor = mainView.changeBGColorButton.backgroundColor
        
        mainView.changeBGColorButton.isHidden = true
        mainView.resetColorsButton.isHidden = false
    }
    
    func resetColors() {
        mainView.backgroundColor = .white
        mainView.changeBGColorButton.backgroundColor = .red
        
        mainView.resetColorsButton.backgroundColor = mainView.backgroundColor
        
        mainView.changeBGColorButton.isHidden = false
        mainView.resetColorsButton.isHidden = true
    }
    
    func setTutorialText(_ text: String?) {
        mainView.tutorialLabel.text = text
    }
}
