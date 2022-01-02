// 
// GitHubService.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

struct GitHubService: GraphQLService {
	private var token: String
	init(token: String) {
		self.token = token
	}

	var url: URL {
		URL(string: "https://api.github.com/graphql")!
	}

	var credentials: GraphQLToken {
		GraphQLToken(type: .bearer, value: token)
	}
}
