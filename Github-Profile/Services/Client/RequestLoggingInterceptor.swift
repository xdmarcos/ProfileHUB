// 
// RequestLoggingInterceptor.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Apollo

final class RequestLoggingInterceptor: ApolloInterceptor {
	func interceptAsync<Operation: GraphQLOperation>(
		chain: RequestChain,
		request: HTTPRequest<Operation>,
		response: HTTPResponse<Operation>?,
		completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
	) {
		DLog("Outgoing request: \(request)")
		
		chain.proceedAsync(
			request: request,
			response: response,
			completion: completion
		)
	}
}


