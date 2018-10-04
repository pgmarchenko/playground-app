//: [Previous](@previous)

import PlaygroundSupport
import Foundation
import DeviceScreenViewController

import App
import UI

let menuVC = MenuScreenViewController()

let (deviceVC, vc) = deviceScreenViewController(
    device: .pad,
    orientation: .portrait,
    child: menuVC,
    showStatusBar: true
)

menuVC.magiColorScreen.assembleMainInteractions()
menuVC.downloadScreen.assembleInteractions()

PlaygroundPage.current.liveView = deviceVC
