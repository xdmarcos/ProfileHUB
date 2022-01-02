// 
// GraphQLToken.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

public struct GraphQLToken {
	public enum AuthType: String {
		case basic
		case bearer
	}

	let type: AuthType
	let value: String
}
