//
// ResponseCodeInterceptorWithErrorCode.swift
// Github-Profile
//
// Created by Marcos González on 2022.
// 
//

import Foundation
import Apollo

public class ResponseCodeInterceptorWithErrorCode: ApolloInterceptor {
	public enum ResponseCodeError: Error, LocalizedError {
		case invalidResponseCode(response: HTTPURLResponse?, rawData: Data?)

		public var errorDescription: String? {
			switch self {
			case let  .invalidResponseCode(response, rawData):
				var errorStrings = [String]()
				if let code = response?.statusCode {
					errorStrings.append("Received a \(code) error.")
				} else {
					errorStrings.append("Did not receive a valid status code.")
				}

				if
					let data = rawData,
					let dataString = String(bytes: data, encoding: .utf8) {
					errorStrings.append("Data returned as a String was:")
					errorStrings.append(dataString)
				} else {
					errorStrings.append("Data was nil or could not be transformed into a string.")
				}

				return errorStrings.joined(separator: " ")
			}
		}
	}

	public func interceptAsync<Operation: GraphQLOperation>(
		chain: RequestChain,
		request: HTTPRequest<Operation>,
		response: HTTPResponse<Operation>?,
		completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>
		) -> Void) {
		guard let statusCode = response?.httpResponse.statusCode,
			  isSuccessCode(statusCode: statusCode) == true else {

				  let error = ResponseCodeError.invalidResponseCode(
					response: response?.httpResponse,
					rawData: response?.rawData
				  )

				  chain.handleErrorAsync(
					error,
					request: request,
					response: response) { result in
						switch result {
						case let .success(response):
							completion(.success(response))
						case let .failure(error):
							let newError = GraphQLServiceError(
								statusCode: response?.httpResponse.statusCode,
								localizedDescription: error.localizedDescription,
								originalError: error
							)
							completion(.failure(newError))
						}
					}
				  return
			  }

		chain.proceedAsync(
			request: request,
			response: response,
			completion: completion
		)
	}
}

private extension ResponseCodeInterceptorWithErrorCode {
	func isSuccessCode(statusCode: Int) -> Bool {
		(200..<300).contains(statusCode)
	}
}
