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
