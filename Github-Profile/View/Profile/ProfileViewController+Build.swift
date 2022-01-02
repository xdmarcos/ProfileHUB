// 
// ProfileViewController+Build.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit
import Common

extension ProfileViewController {
	static func build(delegate: ProfileViewControllerDelegate, configuration: Required) -> UIViewController {
		let graphQLProvider = GraphQLProvider(service: GitHubService(token: configuration.personalAccessToken.value))
		let userDefaults = UserDefaultsHelper()
		let profileRepository = ProfileRepository(provider: graphQLProvider,userDefaults: userDefaults)
		let presenter = ProfilePresenter(repository: profileRepository, configuration: configuration)
		let viewController = ProfileViewController(presenter: presenter)
		viewController.delegate = delegate
		presenter.view = viewController

		return viewController
	}
}
