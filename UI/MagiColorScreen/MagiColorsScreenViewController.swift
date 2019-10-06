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
        case let cmd as MagiColorScreen.SetColors:
            setColors(cmd: cmd)
        case is MagiColorScreen.SetColorMode:
            fillWithButtonColor()
        case is MagiColorScreen.SetDefaultMode:
            resetColors()
        case let cmd as MagiColorScreen.SetTutorialTitle:
            setTutorialText(cmd.title)
        default:
            break
        }
    }
    
    let mainView = MagiColorScreenView()
    let disposeBag = DisposeBag()
    
    private var primaryColor = UIColor.red
    private var defaultColor = UIColor.white
}

extension MagiColorScreenViewController {
    public override func loadView() {
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.changeBGColorButton.rx.controlEvent(.touchUpInside)
            .map { _ in MagiColorScreen.ColorButtonTouched() }
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
        mainView.setColors(primary: primaryColor, default: defaultColor)
        
        mainView.changeBGColorButton.isHidden = false
        mainView.resetColorsButton.isHidden = true
    }
    
    func setColors(cmd: MagiColorScreen.SetColors) {
        guard let primaryColor = cmd.params.primary.uiColor, let defaultColor = cmd.params.default.uiColor else {
            return
        }
        
        self.primaryColor = primaryColor
        self.defaultColor = defaultColor
    }
    
    func setTutorialText(_ text: String?) {
        mainView.tutorialLabel.text = text
    }
}

extension String {
    var uiColor: UIColor? {
        switch self {
        case "red":
            return .red
        case "white":
            return .white
        case "green":
            return .green
        default:
            return nil
        }
    }
}
