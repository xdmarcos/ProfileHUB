//
// RootFlowResolver.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

protocol RootFlowResolver {
	func resolveRootNavigationController() -> UINavigationController
}

final class RootFlowResolverModule: RootFlowResolver {
	func resolveRootNavigationController() -> UINavigationController {
		UINavigationController()
	}
}

