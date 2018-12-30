import UIKit

import RxSwift
import RxCocoa

public class ThirdTabScreenViewController: UIViewController {

    public var onFarewellClicked: ControlEvent<()> {
        return mainView.farewellButton.rx.controlEvent(.touchUpInside)
    }

    public var onGoodbyeClicked: ControlEvent<()> {
        return mainView.goodbyeButton.rx.controlEvent(.touchUpInside)
    }
    
    public func setLabelText(_ text: String?) {
        if isViewLoaded {
            mainView.label.text = text
            Swift.print("Third Screen: set label text '\(text ?? "<nil>")'")
        }
    }

    let mainView = ThirdTabScreenView()
    let disposeBag = DisposeBag()
}


extension ThirdTabScreenViewController {
    
    public override func loadView() {
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelText("первый раз открыт")
    }
}
