// 
// GraphQLClient.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation
import Apollo
import ApolloSQLite

public class GraphQLProvider: GraphQLProviderProtocol {
	private static let sqlFileName = "graphql_db.sqlite"
	private lazy var sqlFileURL: URL = {
		let documentsPath = NSSearchPathForDirectoriesInDomains(
			.documentDirectory,
			.userDomainMask,
			true
		).first!
		let documentsURL = URL(fileURLWithPath: documentsPath)
		return documentsURL.appendingPathComponent(Self.sqlFileName)
	}()

	private lazy var storeCache: NormalizedCache = {
		var cache: NormalizedCache
		if let sqlCache = try? SQLiteNormalizedCache(fileURL: sqlFileURL) {
			cache = sqlCache
		} else {
			cache = InMemoryNormalizedCache()
		}

		return cache
	}()

	private lazy var store: ApolloStore = {
		ApolloStore(cache: storeCache)
	}()

	private(set) lazy var client: ApolloClient = {
		let client = URLSessionClient()
		let provider = NetworkInterceptorProvider(store: store, client: client, token: service.token)
		let url = service.url

		let requestChainTransport = RequestChainNetworkTransport(
			interceptorProvider: provider,
			endpointURL: url
		)

		return ApolloClient(networkTransport: requestChainTransport, store: store)
	}()

	public let service: GraphQLService

	public init(service: GraphQLService) {
		self.service = service
	}

	public func clearCache() {
		store.clearCache()
	}
}
