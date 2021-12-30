// 
// AuthTokenInterceptor.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Apollo

class AuthTokenInterceptor: ApolloInterceptor {
	private static let authHeaderKey = "Authorization"
	private let authToken: GraphQLToken

	init(token: GraphQLToken) {
		authToken = token
	}

	func interceptAsync<Operation: GraphQLOperation>(
		chain: RequestChain,
		request: HTTPRequest<Operation>,
		response: HTTPResponse<Operation>?,
		completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
	) {
		request.addHeader(name: Self.authHeaderKey, value: "\(authToken.type) \(authToken.value)")

		chain.proceedAsync(
			request: request,
			response: response,
			completion: completion
		)
	}
}
