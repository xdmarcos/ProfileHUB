// 
// Credentials.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

#if CONF_PROD
enum QueryItems {
	static let profileToFetch = "xdmarcos"
	static let ghPersonalToken = "_Enter your GitHub personal access token here_"
}
#else
enum QueryItems {
	static let profileToFetch = "_Enter profile name to fetch here_"
	static let ghPersonalToken = "_Enter your GitHub personal access token here_"
}
#endif
