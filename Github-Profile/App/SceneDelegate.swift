//
//  SceneDelegate.swift
//  Github-Profile
//
//  Created by Marcos González on 2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	private var rootCoordinator: RootFlowCoordinator!
	var window: UIWindow?
	
	func scene(
		_ scene: UIScene,
		willConnectTo _: UISceneSession,
		options _: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		window?.backgroundColor = .systemBackground
		window?.makeKeyAndVisible()
		rootCoordinator = RootFlowCoordinator.build(rootWindow: window!)
		rootCoordinator.start()

		window?.windowScene = windowScene
	}
}
