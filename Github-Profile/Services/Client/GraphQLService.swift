// 
// GraphQLService.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

public protocol GraphQLService {
	var url: URL { get }
	var token: GraphQLToken { get }
}
