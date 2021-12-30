// 
// GitHubService.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

struct GithubService: GraphQLService {
	var url: URL {
		URL(string: "https://api.github.com/graphql")!
	}

	// TODO: hide credentials
	var token: GraphQLToken {
		GraphQLToken(type: .bearer, value: Credentials.ghPersonalToken)
	}
}
