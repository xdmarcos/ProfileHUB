//
// RootFlowCoordinator.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit
import Common

final class RootFlowCoordinator: FlowCoordination {
	private let resolver: RootFlowResolver
	private let rootVindow: UIWindow
	private var profileCoordinator: ProfileFlowCoordinator!

	init(resolver: RootFlowResolver, rootVindow: UIWindow) {
		self.resolver = resolver
		self.rootVindow = rootVindow
	}

	func start() {
		let rootNavigationController = resolver.resolveRootNavigationController()
		rootVindow.rootViewController = rootNavigationController
		profileCoordinator = ProfileFlowCoordinator.build(
			navigationController: rootNavigationController
		)
		profileCoordinator.start()
	}
}
