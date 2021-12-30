// 
// GraphQLClient.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation
import Apollo

public class GraphQLProvider: GraphQLProviderProtocol {
	private(set) lazy var client: ApolloClient = {
		let cache = InMemoryNormalizedCache()
		let store = ApolloStore(cache: cache)

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
}
