//
// MockProflilePresenter.swift
// Github-ProfileTests
//
// Created by Marcos González on 2021.
// 
//

import Foundation
@testable import Github_Profile

// sourcery: AutoMockable
extension ProfilePresentable { }

// sourcery:inline:auto:ProfilePresentable.AutoMockable

// swiftlint:disable all

/// The code in this block is automatically generated using Sourcery. Do not edit this code, it will be overwritten.
/// To update this code, run 'sourcery' from the terminal.
final class MockProfilePresentable: ProfilePresentable {

	// MARK: viewDidLoad

	var viewDidLoadCallsCount = 0
	var viewDidLoadCalled: Bool {
		viewDidLoadCallsCount > 0
	}
	var viewDidLoadClosure: (() -> Void)?

	func viewDidLoad() {
		viewDidLoadCallsCount += 1
		viewDidLoadClosure?()
	}

	// MARK: section

	var sectionForCallsCount = 0
	var sectionForCalled: Bool {
		sectionForCallsCount > 0
	}
	var sectionForReceivedIndex: Int?
	var sectionForReceivedInvocations: [Int] = []
	var sectionForReturnValue: Section?
	var sectionForClosure: ((Int) -> Section?)?

	func section(for index: Int) -> Section? {
		sectionForCallsCount += 1
		sectionForReceivedIndex = index
		sectionForReceivedInvocations.append(index)
		return sectionForClosure.map({ $0(index) }) ?? sectionForReturnValue
	}

	// MARK: userProfileInfo

	var userProfileInfoCallsCount = 0
	var userProfileInfoCalled: Bool {
		userProfileInfoCallsCount > 0
	}
	var userProfileInfoReturnValue: HeaderViewModel!
	var userProfileInfoClosure: (() -> HeaderViewModel)?

	func userProfileInfo() -> HeaderViewModel {
		userProfileInfoCallsCount += 1
		return userProfileInfoClosure.map({ $0() }) ?? userProfileInfoReturnValue
	}

	// MARK: reloadData

	var reloadDataCallsCount = 0
	var reloadDataCalled: Bool {
		reloadDataCallsCount > 0
	}
	var reloadDataClosure: (() -> Void)?

	func reloadData() {
		reloadDataCallsCount += 1
		reloadDataClosure?()
	}

	// MARK: repositoryId

	var repositoryIdIndexPathCallsCount = 0
	var repositoryIdIndexPathCalled: Bool {
		repositoryIdIndexPathCallsCount > 0
	}
	var repositoryIdIndexPathReceivedIndexPath: IndexPath?
	var repositoryIdIndexPathReceivedInvocations: [IndexPath] = []
	var repositoryIdIndexPathClosure: ((IndexPath) -> Void)?

	func repositoryId(indexPath: IndexPath) {
		repositoryIdIndexPathCallsCount += 1
		repositoryIdIndexPathReceivedIndexPath = indexPath
		repositoryIdIndexPathReceivedInvocations.append(indexPath)
		repositoryIdIndexPathClosure?(indexPath)
	}
}

// swiftlint:enable all

// sourcery:end
