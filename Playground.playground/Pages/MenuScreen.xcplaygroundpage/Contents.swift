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

menuVC.assembleInterations()

PlaygroundPage.current.liveView = deviceVC
