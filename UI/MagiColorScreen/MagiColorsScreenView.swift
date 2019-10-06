import Foundation
import UIKit
import SnapKit

public class MagiColorScreenView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColors(primary: UIColor, default: UIColor) {
        hiddenLabel.textColor = `default`
        hidingLabel.textColor = primary
        
        backgroundColor = `default`
        changeBGColorButton.backgroundColor = primary
        
        resetColorsButton.backgroundColor = backgroundColor
    }
    
    let hiddenLabel = UILabel()
    let hidingLabel = UILabel()
    
    let changeBGColorButton = UIButton()
    let resetColorsButton = UIButton()
    
    let tutorialButton = UIButton()
    let tutorialLabel = UILabel()
}

extension MagiColorScreenView {
    private func assemble() {
        hiddenLabel.text = "Hidden white text"
        
        hidingLabel.text = "Will hide"
        
        tutorialButton.setTitle("TUTORIAL", for: .normal)
        tutorialButton.backgroundColor = .orange
        
        tutorialLabel.textAlignment = .center
        tutorialLabel.numberOfLines = 0
        
        addSubview(hiddenLabel)
        addSubview(hidingLabel)
        addSubview(changeBGColorButton)
        addSubview(resetColorsButton)
        addSubview(tutorialButton)
        addSubview(tutorialLabel)
        
        setupLayout()
    }
    
    private func setupLayout() {
        tutorialButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 50))
            make.top.equalTo(self.snp.topMargin)
            make.right.equalTo(self.snp.rightMargin)
        }
        
        tutorialLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(100)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 300, height: 100))
        }
        
        hiddenLabel.snp.makeConstraints { make in
            make.bottom.equalTo(changeBGColorButton.snp.top).offset(0)
            make.size.equalTo(changeBGColorButton)
            make.centerX.equalTo(changeBGColorButton.snp.centerX)
        }
        
        hidingLabel.snp.makeConstraints { make in
            make.top.equalTo(changeBGColorButton.snp.bottom).offset(0)
            make.size.equalTo(changeBGColorButton)
            make.centerX.equalTo(changeBGColorButton.snp.centerX)
        }
        
        changeBGColorButton.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 200, height: 50))
        }
        
        resetColorsButton.snp.makeConstraints { make in
            make.edges.equalTo(changeBGColorButton)
        }
    }
}
 
