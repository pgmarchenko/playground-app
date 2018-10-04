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
    
    let waitingOverlayView = UIView()
    let cancelWaitingButton = UIButton()
}

extension DownloadScreenView {
    private func assemble() {
        self.backgroundColor = .orange
        
        downloadAndOpenButton.backgroundColor = .black
        downloadAndOpenButton.setTitle("Download & Open", for: .normal)
        
        waitingOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        cancelWaitingButton.backgroundColor = .brown
        cancelWaitingButton.setTitle("Cancel", for: .normal)
        
        addSubview(downloadAndOpenButton)
        addSubview(waitingOverlayView)
        
        waitingOverlayView.addSubview(cancelWaitingButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        downloadAndOpenButton.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 200, height: 50))
        }
        
        waitingOverlayView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        cancelWaitingButton.snp.makeConstraints { make in
            make.edges.equalTo(downloadAndOpenButton)
        }
    }
}

