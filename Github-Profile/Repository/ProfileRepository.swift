// 
// ProfileRepository.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

struct ProfileRepository: ProfileRepositoryProtocol {
	private let provider: GraphQLProviderProtocol

	init(provider: GraphQLProviderProtocol) {
		self.provider = provider
	}

	func userProfileRepositories(
		username: String,
		completion: @escaping ProfileRepositoryProtocol.ProfileCompletion
	) {
		guard let provider = provider as? GraphQLProvider else { return }

		let query = UserProfileReposQuery(login: username)
		provider.client.fetch(query: query, cachePolicy: .default) { result in
			switch result {
			case let .success(graphQLResult):
				var graphqlError: RepositoryError?
				if let errors = graphQLResult.errors {
					let message = errors.map { $0.localizedDescription }.joined(separator: "\n")
					graphqlError = .graphQL(messsage: message)
				}

				let response = UserProfileQueryResponse(
					userProfile: graphQLResult.data?.user,
					graphQLError: graphqlError)
				completion(.success(response))
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
}
