// 
// UserProfileQueryResponse.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

public struct UserProfileQueryResponse {
	let userProfile:  UserProfile?
	let graphQLError: Error?
}
