// 
// ProfileRepository.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation
import Common
import KeyChain

struct ProfileRepository: ProfileRepositoryProtocol {
	private static let minutesThreshold = 24 * 60 // 1 day in minutes
	private let provider: GraphQLProviderProtocol
	private let userDefaults: UserDefaultsHelperProtocol

	init(provider: GraphQLProviderProtocol, userDefaults: UserDefaultsHelperProtocol) {
		self.provider = provider
		self.userDefaults = userDefaults
	}

	func userProfileRepositories(
		username: String,
		completion: @escaping ProfileCompletion
	) {
		let updated = updateTokenIfNeeded()
		resetCacheIfNeeded(force: updated)
		fetchUserProfile(username, completion: completion)
	}
}

private extension ProfileRepository {
	func updateTokenIfNeeded() -> Bool {
		guard let savedToken = KeyChain.string(forKey: Constants.keyChainCredentialsKey),
			  let provider = provider as? GraphQLProvider,
			  provider.service.credentials.value != savedToken  else {
				  return false
			  }

		provider.service = GitHubService(token: savedToken)
		provider.resetClient()
		return true
	}

	func resetCacheIfNeeded(force: Bool) {
		let dateNow = Date()
		guard !force else {
			restetCache(newDate: dateNow)
			return
		}
		
		guard let lastCheckDate = userDefaults.read(key: Constants.userDefaultsCacheDateKey) as? Date else {
			userDefaults.write(value: dateNow as NSDate, key: Constants.userDefaultsCacheDateKey)
			return
		}

		guard let diff = Calendar.current.dateComponents([.minute], from: lastCheckDate, to: dateNow).minute,
			  diff >= Self.minutesThreshold else { return }

		restetCache(newDate: dateNow)
	}

	func restetCache(newDate: Date) {
		provider.clearCache()
		userDefaults.write(value: newDate as NSDate, key: Constants.userDefaultsCacheDateKey)
	}

	func fetchUserProfile(
		_ username: String,
		completion: @escaping ProfileCompletion
	) {
		guard let provider = provider as? GraphQLProvider else { return }

		let query = UserProfileReposQuery(login: username)
		provider.fetch(query: query, cachePolicy: .default) { result in
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
