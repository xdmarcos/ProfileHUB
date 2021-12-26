// 
// ResponseLoggingInterceptor.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Apollo

final class ResponseLoggingInterceptor: ApolloInterceptor {
	enum ResponseLoggingError: Error {
		case notYetReceived
	}

	func interceptAsync<Operation: GraphQLOperation>(
		chain: RequestChain,
		request: HTTPRequest<Operation>,
		response: HTTPResponse<Operation>?,
		completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
	) {
		defer {
			chain.proceedAsync(
				request: request,
				response: response,
				completion: completion
			)
		}

		guard let receivedResponse = response else {
			chain.handleErrorAsync(
				ResponseLoggingError.notYetReceived,
				request: request,
				response: response,
				completion: completion
			)
			return
		}

		// TODO: change with debugLog
		print("HTTP Response: \(receivedResponse.httpResponse)")

		guard let stringData = String(bytes: receivedResponse.rawData, encoding: .utf8) else {
			print("Could not convert data to string!")
			return
		}
		print("Data: \(stringData)")
	}
}


