// 
// NetworkInterceptorProvider.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Apollo

struct NetworkInterceptorProvider: InterceptorProvider {
	private let store: ApolloStore
	private let client: URLSessionClient
	private let token: Token

	init(store: ApolloStore, client: URLSessionClient, token: Token) {
		self.store = store
		self.client = client
		self.token = token
	}

	func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
		return [
			AuthTokenInterceptor(token: token),
			MaxRetryInterceptor(),
			CacheReadInterceptor(store: self.store),
			RequestLoggingInterceptor(),
			NetworkFetchInterceptor(client: self.client),
			ResponseLoggingInterceptor(),
			ResponseCodeInterceptor(),
			JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
			AutomaticPersistedQueryInterceptor(),
			CacheWriteInterceptor(store: self.store)
		]
	}
}


