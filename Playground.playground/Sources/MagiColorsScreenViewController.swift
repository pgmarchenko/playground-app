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
    
    let mainView = MagiColorScreenView()
    let disposeBag = DisposeBag()
}

extension MagiColorScreenViewController {
    public override func loadView() {
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        resetColors()
    }
}
