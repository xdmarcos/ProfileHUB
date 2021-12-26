// 
// ProfileRepositoryProtocol.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

protocol ProfileRepositoryProtocol {
	typealias ProfileCompletion = (Result<UserProfileQueryResponse, Error>) -> Void
	func userProfileRepositories(username: String, completion: @escaping ProfileCompletion)
}
