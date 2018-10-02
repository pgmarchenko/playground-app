import Foundation
import UIKit

public class ListScreenView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListScreenView {
    private func assemble() {
        self.backgroundColor = .orange
    }
}
