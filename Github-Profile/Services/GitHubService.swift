// 
// GitHubService.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

struct GithubService: Service {
	var url: URL {
		URL(string: "https://api.github.com/graphql")!
	}

	// TODO: hide credentials
	var token: Token {
		Token(type: .bearer, value: "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")
	}
}
