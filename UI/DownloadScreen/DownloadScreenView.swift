import Foundation
import UIKit

import SnapKit

public class DownloadScreenView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let downloadAndOpenButton = UIButton()
    let openPremiumButton = UIButton()
    
    let waitingOverlayView = UIView()
    let cancelWaitingButton = UIButton()
    let retryButton = UIButton()
}

extension DownloadScreenView {
    private func assemble() {
        self.backgroundColor = .brown
        
        downloadAndOpenButton.backgroundColor = .red
        downloadAndOpenButton.setTitle("Open Red&White", for: .normal)
        
        openPremiumButton.backgroundColor = .green
        openPremiumButton.setTitle("Open Green&White", for: .normal)
        
        waitingOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        cancelWaitingButton.backgroundColor = .brown
        cancelWaitingButton.setTitle("Cancel", for: .normal)
        
        retryButton.backgroundColor = .green
        retryButton.setTitle("Retry", for: .normal)
        
        addSubview(downloadAndOpenButton)
        addSubview(openPremiumButton)
        addSubview(waitingOverlayView)
        
        waitingOverlayView.addSubview(cancelWaitingButton)
        waitingOverlayView.addSubview(retryButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        downloadAndOpenButton.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 200, height: 50))
        }
        
        openPremiumButton.snp.makeConstraints { make in
            make.top.equalTo(downloadAndOpenButton.snp.bottom).offset(20)
            make.centerX.equalTo(downloadAndOpenButton)
            make.size.equalTo(downloadAndOpenButton)
        }
        
        waitingOverlayView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        cancelWaitingButton.snp.makeConstraints { make in
            make.edges.equalTo(downloadAndOpenButton)
        }
        
        retryButton.snp.makeConstraints { make in
            make.edges.equalTo(downloadAndOpenButton)
        }
    }
}

