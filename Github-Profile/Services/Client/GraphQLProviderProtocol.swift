// 
// GraphQLProviderProtocol.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation
import Apollo

public protocol GraphQLProviderProtocol {
	var service: GraphQLService { get }
	func fetch<Query: GraphQLQuery>(query: Query,cachePolicy: CachePolicy, resultHandler: GraphQLResultHandler<Query.Data>?)
	func clearCache()
}
