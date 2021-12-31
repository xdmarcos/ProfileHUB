//
// MockProfileViewController.swift
// Github-ProfileTests
//
// Created by Marcos González on 2021.
// 
//

import Foundation
@testable import Github_Profile

// sourcery: AutoMockable
extension ProfileViewDisplayable { }

// sourcery:inline:auto:ProfileViewDisplayable.AutoMockable

// swiftlint:disable all

/// The code in this block is automatically generated using Sourcery. Do not edit this code, it will be overwritten.
/// To update this code, run 'sourcery' from the terminal.
final class MockProfileViewDisplayable: ProfileViewDisplayable {

	// MARK: displayView

	var displayViewScreenTitleSectionsCallsCount = 0
	var displayViewScreenTitleSectionsCalled: Bool {
		displayViewScreenTitleSectionsCallsCount > 0
	}
	var displayViewScreenTitleSectionsReceivedArguments: (screenTitle: String, sections: [Section])?
	var displayViewScreenTitleSectionsReceivedInvocations: [(screenTitle: String, sections: [Section])] = []
	var displayViewScreenTitleSectionsClosure: ((String, [Section]) -> Void)?

	func displayView(screenTitle: String, sections: [Section]) {
		displayViewScreenTitleSectionsCallsCount += 1
		displayViewScreenTitleSectionsReceivedArguments = (screenTitle: screenTitle, sections: sections)
		displayViewScreenTitleSectionsReceivedInvocations.append((screenTitle: screenTitle, sections: sections))
		displayViewScreenTitleSectionsClosure?(screenTitle, sections)
	}

	// MARK: reloadData

	var reloadDataWithCallsCount = 0
	var reloadDataWithCalled: Bool {
		reloadDataWithCallsCount > 0
	}
	var reloadDataWithReceivedSections: [Section]?
	var reloadDataWithReceivedInvocations: [[Section]] = []
	var reloadDataWithClosure: (([Section]) -> Void)?

	func reloadData(with sections: [Section]) {
		reloadDataWithCallsCount += 1
		reloadDataWithReceivedSections = sections
		reloadDataWithReceivedInvocations.append(sections)
		reloadDataWithClosure?(sections)
	}

	// MARK: showLoaderIndicator

	var showLoaderIndicatorCallsCount = 0
	var showLoaderIndicatorCalled: Bool {
		showLoaderIndicatorCallsCount > 0
	}
	var showLoaderIndicatorClosure: (() -> Void)?

	func showLoaderIndicator() {
		showLoaderIndicatorCallsCount += 1
		showLoaderIndicatorClosure?()
	}

	// MARK: hideLoaderIndicator

	var hideLoaderIndicatorCallsCount = 0
	var hideLoaderIndicatorCalled: Bool {
		hideLoaderIndicatorCallsCount > 0
	}
	var hideLoaderIndicatorClosure: (() -> Void)?

	func hideLoaderIndicator() {
		hideLoaderIndicatorCallsCount += 1
		hideLoaderIndicatorClosure?()
	}

	// MARK: showErrorMessage

	var showErrorMessageTitleMessageCallsCount = 0
	var showErrorMessageTitleMessageCalled: Bool {
		showErrorMessageTitleMessageCallsCount > 0
	}
	var showErrorMessageTitleMessageReceivedArguments: (title: String, message: String)?
	var showErrorMessageTitleMessageReceivedInvocations: [(title: String, message: String)] = []
	var showErrorMessageTitleMessageClosure: ((String, String) -> Void)?

	func showErrorMessage(title: String, message: String) {
		showErrorMessageTitleMessageCallsCount += 1
		showErrorMessageTitleMessageReceivedArguments = (title: title, message: message)
		showErrorMessageTitleMessageReceivedInvocations.append((title: title, message: message))
		showErrorMessageTitleMessageClosure?(title, message)
	}

	// MARK: repositoryItemDidFind

	var repositoryItemDidFindItemCallsCount = 0
	var repositoryItemDidFindItemCalled: Bool {
		repositoryItemDidFindItemCallsCount > 0
	}
	var repositoryItemDidFindItemReceivedItem: Repository?
	var repositoryItemDidFindItemReceivedInvocations: [Repository] = []
	var repositoryItemDidFindItemClosure: ((Repository) -> Void)?

	func repositoryItemDidFind(item: Repository) {
		repositoryItemDidFindItemCallsCount += 1
		repositoryItemDidFindItemReceivedItem = item
		repositoryItemDidFindItemReceivedInvocations.append(item)
		repositoryItemDidFindItemClosure?(item)
	}
}

// swiftlint:enable all

// sourcery:end
