//: [Previous](@previous)

import PlaygroundSupport
import Foundation
import DeviceScreenViewController

let (deviceVC, vc) = deviceScreenViewController(
    device: .phoneX,
    orientation: .portrait,
    child: MenuScreenViewController(),
    showStatusBar: true
)

PlaygroundPage.current.liveView = deviceVC
