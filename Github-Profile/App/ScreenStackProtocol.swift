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
		let rootVC = RootViewController()
		let window = UIWindow(windowScene: windowScene)
		window.backgroundColor = .systemBackground
		window.rootViewController = rootVC
		
		return window
	}
}
