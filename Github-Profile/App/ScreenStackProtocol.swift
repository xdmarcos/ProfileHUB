//
//  ScreenStackProtocol.swift
//  Github-Profile
//
//  Created by Marcos González on 2021.
//

import UIKit

protocol ScreenStackProtocol {
	func windowForScene(_ windowScene: UIWindowScene) -> UIWindow
}

extension ScreenStackProtocol {
	func windowForScene(_ windowScene: UIWindowScene) -> UIWindow {
		let window = UIWindow(windowScene: windowScene)
		window.backgroundColor = .systemBackground
		let rootCoordinator = RootFlowCoordinator.build(rootWindow: window)
		rootCoordinator.start()
		
		return window
	}
}
