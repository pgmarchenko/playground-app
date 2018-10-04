import Foundation
import UIKit

import RxSwift
import RxCocoa

public class DownloadScreenViewController: UIViewController {
    public var onDownloadAndOpenClicked: ControlEvent<()> {
        return mainView.downloadAndOpenButton.rx.controlEvent(.touchUpInside)
    }
    
    public var onCancelDownloadClicked: ControlEvent<()> {
        return mainView.cancelWaitingButton.rx.controlEvent(.touchUpInside)
    }
    
    public var onRetryDownloadClicked: ControlEvent<()> {
        return mainView.retryButton.rx.controlEvent(.touchUpInside)
    }
    
    public func showWaitingOverlay(_ show: Bool = true) {
        mainView.waitingOverlayView.isHidden = !show
    }
    
    public func showRetry(_ show: Bool = true) {
        debugPrint(#function)
        mainView.cancelWaitingButton.isHidden = show
        mainView.retryButton.isHidden = !show
    }
    
    let mainView = DownloadScreenView()
    let disposeBag = DisposeBag()
}

extension DownloadScreenViewController {
    public override func loadView() {
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        showWaitingOverlay(false)
    }
}
