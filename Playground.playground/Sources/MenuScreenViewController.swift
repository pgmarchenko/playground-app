import Foundation
import UIKit

public class MenuScreenViewController: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        leftList.view.backgroundColor = .green
        leftList.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        rightList.view.backgroundColor = .red
        rightList.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        viewControllers = [leftList, rightList]
    }
    
    public let leftList = DownloadScreenViewController()
    public let rightList = UIViewController()
}
