import PlaygroundSupport
import Foundation
import UIKit

import SnapKit
import RxSwift
import RxCocoa

import Utilities

let vc = DownloadScreenViewController()

vc.onDownloadAndOpenClicked.bind { _ in
    let disposer = CompositeDisposable()
    
    vc.showWaitingOverlay()
    
    vc.onCancelLongOperationClicked.bind(disposing: disposer) { _, _ in
        vc.showWaitingOverlay(false)
    }
}

PlaygroundPage.current.liveView = vc
