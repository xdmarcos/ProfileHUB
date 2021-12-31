// 
// ProfileRepository.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation
import Common

struct ProfileRepository: ProfileRepositoryProtocol {
	private static let userDefaultscacheDateKey = "UserDefaultsCacheDate"
	private static let minutesThreshold = 24 * 60 // 1 day in minutes
	private let provider: GraphQLProviderProtocol
	private let userDefaults: UserDefaultsHelperProtocol

	init(provider: GraphQLProviderProtocol, userDefaults: UserDefaultsHelperProtocol) {
		self.provider = provider
		self.userDefaults = userDefaults
	}

	func userProfileRepositories(
		username: String,
		completion: @escaping ProfileRepositoryProtocol.ProfileCompletion
	) {
		restetCacheIfNeeded()
		fetchUserProfile(username, completion: completion)
	}
}

private extension ProfileRepository {
	func restetCacheIfNeeded() {
		let dateNow = Date()

		guard let lastCheckDate = userDefaults.read(key: Self.userDefaultscacheDateKey) as? Date else {
			userDefaults.write(value: dateNow as NSDate, key: Self.userDefaultscacheDateKey)
			return
		}

		guard let diff = Calendar.current.dateComponents([.minute], from: lastCheckDate, to: dateNow).minute,
			  diff >= Self.minutesThreshold else { return }

		provider.clearCache()
		userDefaults.write(value: dateNow as NSDate, key: Self.userDefaultscacheDateKey)
	}

	func fetchUserProfile(
		_ username: String,
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
