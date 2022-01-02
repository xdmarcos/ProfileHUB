//
// RootFlowCoordinator+Build.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

extension RootFlowCoordinator {
	static func build(rootWindow: UIWindow) -> RootFlowCoordinator {
		let resolver = RootFlowResolverModule()
		let coordinator = RootFlowCoordinator(
			resolver: resolver,
			rootVindow: rootWindow
		)
		return coordinator
	}
}
