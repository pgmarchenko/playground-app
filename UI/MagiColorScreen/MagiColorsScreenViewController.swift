import Foundation
import UIKit

import RxSwift
import RxCocoa

import Utilities


public class MagiColorScreenViewController: UIViewController {
    public var onChangeBGColorClicked: ControlEvent<()> {
        return mainView.changeBGColorButton.rx.controlEvent(.touchUpInside)
    }
    
    public var onResetColorsClicked: ControlEvent<()> {
        return mainView.resetColorsButton.rx.controlEvent(.touchUpInside)
    }
    
    public var onTutorialClicked: ControlEvent<()> {
        return mainView.tutorialButton.rx.controlEvent(.touchUpInside)
    }
    
    public var challengeMode: Observable<Bool> {
        let switchControl = mainView.challengeModeSwitch
        return switchControl.rx.controlEvent(.valueChanged).withLatestFrom(switchControl.rx.value)
    }
    
    public func fillWithButtonColor() {
        mainView.backgroundColor = mainView.changeBGColorButton.backgroundColor
        
        mainView.changeBGColorButton.isHidden = true
        mainView.resetColorsButton.isHidden = false
    }
    
    public func resetColors() {
        mainView.backgroundColor = .white
        mainView.changeBGColorButton.backgroundColor = .red
        
        mainView.resetColorsButton.backgroundColor = mainView.backgroundColor
        
        mainView.changeBGColorButton.isHidden = false
        mainView.resetColorsButton.isHidden = true
    }
    
    public func setTutorialText(_ text: String?) {
        mainView.tutorialLabel.text = text
    }
    
    public func updateToTutorialMode() {
        setTutorialText("Tutorial mode!")
        mainView.hidingLabelPosition = .normal
        mainView.challengeModePad.isHidden = true
        mainView.challengeModeSwitch.isOn = false
    }
    
    public func updateToMainMode() {
        setTutorialText(nil)
        mainView.hidingLabelPosition = .normal
        mainView.challengeModePad.isHidden = false
        mainView.challengeModeSwitch.isOn = false
    }
    
    public func updateToChallengeMode() {
        self.resetColors()
        setTutorialText(nil)
        mainView.challengeModePad.isHidden = false
        mainView.challengeModeSwitch.isOn = true
    }
    
    public func setHidingLabelPositionTop() {
        mainView.hidingLabelPosition = .top
    }
    
    public func setHidingLabelPositionBottom() {
        mainView.hidingLabelPosition = .bottom
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
        
        self.resetColors()
    }
}
