// 
// GitHubConfiguration.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

struct Required: Equatable {
	enum Item: Equatable {
		case profileName(String)
		case token(String)

		var value: String {
			switch self {
			case let .profileName(value):
				return value
			case let .token(value):
				return value
			}
		}
	}
	
	var profileToFetch: Item
	var personalAccessToken: Item
}

#if CONF_PROD
enum Configuration {
	static var github = Required(
		profileToFetch: .profileName("xdmarcos"),
		personalAccessToken: .token("***_Enter your GitHub personal access token here_***")
	)
}

#else
enum Configuration {
	static var github = Required(
		profileToFetch: .profileName("***_Enter profile name to fetch here_***"),
		personalAccessToken: .token("***_Enter your GitHub personal access token here_***")
	)
}
#endif
