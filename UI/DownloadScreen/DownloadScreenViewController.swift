import Foundation
import UIKit

import RxSwift
import RxCocoa

import AppEntities

public class DownloadScreenViewController: UIViewController {
    public let events = PublishSubject<FeatureFlowEvent>()
    
    public func dispatchCommand(_ cmd: FeatureFlowCommand) {
        switch cmd {
        case is UI.Show<DownloadWaitingOverlay>:
            showWaitingOverlay()
            showRetry(false)
        case is UI.Hide<DownloadWaitingOverlay>:
            showWaitingOverlay(false)
        case is DownloadWaitingOverlay.ShowRetry:
            showRetry()
        case is DownloadWaitingOverlay.HideRetry:
            showRetry(false)
        default:
            break
        }
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
        
        mainView.downloadAndOpenButton.rx.controlEvent(.touchUpInside)
            .map { _ in DownloadScreen.DownloadAndOpen() }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        mainView.cancelWaitingButton.rx.controlEvent(.touchUpInside)
            .map { _ in DownloadScreen.DownloadingCancelled() }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        mainView.retryButton.rx.controlEvent(.touchUpInside)
            .map { _ in DownloadWaitingOverlay.Retry() }
            .bind(to: events)
            .disposed(by: disposeBag)
        
        showWaitingOverlay(false)
    }
}

extension DownloadScreenViewController {
    private func showWaitingOverlay(_ show: Bool = true) {
        mainView.waitingOverlayView.isHidden = !show
    }
    
    private func showRetry(_ show: Bool = true) {
        mainView.cancelWaitingButton.isHidden = show
        mainView.retryButton.isHidden = !show
    }
}
