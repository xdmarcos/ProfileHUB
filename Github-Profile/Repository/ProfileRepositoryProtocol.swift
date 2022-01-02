// 
// ProfileRepositoryProtocol.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

protocol ProfileRepositoryProtocol {
	func userProfileRepositories(username: String, completion: @escaping ProfileCompletion)
}
