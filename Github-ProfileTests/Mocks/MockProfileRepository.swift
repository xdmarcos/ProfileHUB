//
// MockProfileRepository.swift
// Github-ProfileTests
//
// Created by Marcos González on 2022.
// 
//

import Foundation
@testable import Github_Profile

// sourcery: AutoMockable, mockName=MockProfileRepository
extension ProfileRepositoryProtocol { }

// sourcery:inline:auto:ProfileRepositoryProtocol.AutoMockable

// swiftlint:disable all

/// The code in this block is automatically generated using Sourcery. Do not edit this code, it will be overwritten.
/// To update this code, run 'sourcery' from the terminal.
final class MockProfileRepository: ProfileRepositoryProtocol {

	// MARK: userProfileRepositories

	var userProfileRepositoriesUsernameCompletionCallsCount = 0
	var userProfileRepositoriesUsernameCompletionCalled: Bool {
		userProfileRepositoriesUsernameCompletionCallsCount > 0
	}
	var userProfileRepositoriesUsernameCompletionReceivedArguments: (username: String, completion: ProfileCompletion)?
	var userProfileRepositoriesUsernameCompletionReceivedInvocations: [(username: String, completion: ProfileCompletion)] = []
	var userProfileRepositoriesUsernameCompletionClosure: ((String, @escaping ProfileCompletion) -> Void)?

	func userProfileRepositories(username: String, completion: @escaping ProfileCompletion) {
		userProfileRepositoriesUsernameCompletionCallsCount += 1
		userProfileRepositoriesUsernameCompletionReceivedArguments = (username: username, completion: completion)
		userProfileRepositoriesUsernameCompletionReceivedInvocations.append((username: username, completion: completion))
		userProfileRepositoriesUsernameCompletionClosure?(username, completion)
	}
}

// swiftlint:enable all

// sourcery:end
