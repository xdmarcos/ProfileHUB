//
//  AppDelegate.swift
//  Github-Profile
//
//  Created by Marcos González on 2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let githubClient = GraphQLProvider(service: GithubService()).client
		githubClient.fetch(
			query: UserProfileReposQuery(login: "xdmarcos"),
			cachePolicy: .default,
			queue: .main
		)
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(
		_: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options _: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		UISceneConfiguration(
			name: "Default Configuration",
			sessionRole: connectingSceneSession.role
		)
	}
}
