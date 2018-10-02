import Foundation
import UIKit

public class ListScreenViewController: UIViewController {
    
    let mainView = ListScreenView()
}

extension ListScreenViewController {
    public override func loadView() {
        view = mainView
    }
}
