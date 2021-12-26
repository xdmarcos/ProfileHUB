// 
// UserProfileQueryResponse.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

struct UserProfileQueryResponse {
	let userProfile:  UserProfileReposQuery.Data.User?
	let graphQLError: Error?
}
