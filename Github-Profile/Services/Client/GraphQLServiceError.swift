//
// GraphQLError.swift
// Github-Profile
//
// Created by Marcos González on 2022.
// 
//

import Foundation

public struct GraphQLServiceError: Error {
	let statusCode: Int?
	let localizedDescription: String
	let originalError: Error
}
