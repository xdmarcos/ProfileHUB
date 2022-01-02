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

final public class GraphQLProvider: GraphQLProviderProtocol {
	private static let sqlFileName = "gz.xdmdev.graphql_db.sqlite"
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

	private lazy var urlSessionClient: URLSessionClient = {
		URLSessionClient()
	}()

	private var client: ApolloClient!

	public var service: GraphQLService

	public init(service: GraphQLService) {
		self.service = service
		self.client = configureClient()
	}

	func resetClient() {
		client = configureClient()
	}

	public func clearCache() {
		store.clearCache()
	}

	public func fetch<Query: GraphQLQuery>(
		query: Query,
		cachePolicy: CachePolicy = .default,
		resultHandler: GraphQLResultHandler<Query.Data>? = nil
	) {
		client.fetch(query: query, cachePolicy: cachePolicy, resultHandler: resultHandler)
	}
}

private extension GraphQLProvider {
	private func configureClient() -> ApolloClient {
		let provider = NetworkInterceptorProvider(
			store: store,
			client: urlSessionClient,
			token: service.credentials
		)

		let requestChainTransport = RequestChainNetworkTransport(
			interceptorProvider: provider,
			endpointURL: service.url
		)

		return ApolloClient(networkTransport: requestChainTransport, store: store)
	}
}
