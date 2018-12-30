import Foundation
import UIKit
import SnapKit

public class MagiColorScreenView: UIView {
    
    enum LabelPosition {
        case normal
        case top
        case bottom
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let hiddenLabel = UILabel()
    let hidingLabel = UILabel()
    
    let changeBGColorButton = UIButton()
    let resetColorsButton = UIButton()
    
    let tutorialButton = UIButton()
    let tutorialLabel = UILabel()
    
    let challengeModeSwitch = UISwitch()
    let challengeModePad = UIStackView()
    
    var hidingLabelPosition: LabelPosition = .normal {
        didSet {
            if hidingLabelPosition != oldValue {
                updateHidingLabelPosition()
            }
        }
    }
    
    private let challengeModeLabel = UILabel()
}

extension MagiColorScreenView {
    private func assemble() {
        hiddenLabel.text = "Hidden white text"
        hiddenLabel.textColor = .white
        
        hidingLabel.text = "Will hide"
        hidingLabel.textColor = .red
        
        tutorialButton.setTitle("TUTORIAL", for: .normal)
        tutorialButton.backgroundColor = .orange
        
        tutorialLabel.textAlignment = .center
        tutorialLabel.numberOfLines = 0
        
        challengeModeLabel.text = "Challenge Mode";
        challengeModePad.addArrangedSubview(challengeModeSwitch)
        challengeModePad.addArrangedSubview(challengeModeLabel)

        addSubview(hiddenLabel)
        addSubview(hidingLabel)
        addSubview(changeBGColorButton)
        addSubview(resetColorsButton)
        addSubview(tutorialButton)
        addSubview(tutorialLabel)
        addSubview(challengeModePad)
        
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
        
        updateHidingLabelPosition()

        changeBGColorButton.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 200, height: 50))
        }
        
        resetColorsButton.snp.makeConstraints { make in
            make.edges.equalTo(changeBGColorButton)
        }
        
        challengeModePad.axis = .horizontal
        challengeModePad.alignment = .center
        challengeModePad.distribution = .equalSpacing
        challengeModePad.spacing = 10;
        challengeModePad.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottomMargin).offset(-50)
            make.centerX.equalToSuperview()
        }
    }
    
    private func updateHidingLabelPosition() {
        
        hidingLabel.snp.remakeConstraints { make in
            switch hidingLabelPosition {
            case .normal:
                make.top.equalTo(changeBGColorButton.snp.bottom).offset(0)
            case .bottom:
                make.bottom.equalTo(snp.bottomMargin).offset(0)
            case .top:
                make.top.equalTo(snp.topMargin).offset(0)
            }
            
            make.size.equalTo(changeBGColorButton)
            make.centerX.equalTo(changeBGColorButton.snp.centerX)
        }
    }
}
 
