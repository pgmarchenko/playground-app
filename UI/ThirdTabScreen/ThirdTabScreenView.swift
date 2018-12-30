import UIKit
import SnapKit

public class ThirdTabScreenView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
    }

    @available(*, unavailable) required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = UILabel()
    let farewellButton = UIButton()
    let goodbyeButton = UIButton()
    
    private let stackView = UIStackView()
}

extension ThirdTabScreenView {
    private func assemble() {
        
        backgroundColor = .lightGray
        
        addSubview(stackView)

        label.numberOfLines = 0;
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize + 3, weight: .medium)
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
        
        farewellButton.backgroundColor = .red
        farewellButton.setTitle("прощай", for: .normal)
        stackView.addArrangedSubview(farewellButton)
        
        goodbyeButton.backgroundColor = .blue
        goodbyeButton.setTitle("до встречи", for: .normal)
        stackView.addArrangedSubview(goodbyeButton)
        
        setupLayout()
    }
    
    private func setupLayout() {

        let buttonSize = CGSize(width: 200, height: 50)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 50;
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }

        label.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).offset(-100)
        }
        
        farewellButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
        }

        goodbyeButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
        }
    }
}
