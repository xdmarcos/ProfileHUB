//
// ProfilePresenterTests.swift
// Github-ProfileTests
//
// Created by Marcos González on 2021.
// 
//

import XCTest
@testable import Github_Profile

final class ProfilePresenterTests: XCTestCase {
	private var sut: ProfilePresenter!
	private var profileRepositoryMock: MockProfileRepositoryProtocol!
	private var viewController: MockProfileViewDisplayable!

    override func setUp() {
		profileRepositoryMock = MockProfileRepositoryProtocol()
        sut = ProfilePresenter(repository: profileRepositoryMock)
		viewController = MockProfileViewDisplayable()
		sut.view = viewController
    }

    override func tearDown(){
        profileRepositoryMock = nil
		viewController = nil
		sut = nil
    }

	func testPresenterViewDidLoadCallsViewWhenSuccess() {
		// Given
		let response = UserProfileQueryResponse(userProfile: userProfileResponseMock, graphQLError: nil)
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.success(response))
		}

		// When
		sut.viewDidLoad()

		// Then
		XCTAssertTrue(viewController.showLoaderIndicatorCalled)
		XCTAssertTrue(viewController.displayViewScreenTitleSectionsCalled)
		XCTAssertFalse(viewController.showErrorMessageTitleMessageCalled)
		XCTAssertTrue(viewController.hideLoaderIndicatorCalled)
	}

	func testPresenterViewDidLoadCallsViewWhenFailure() {
		// Given
		let response = userProfileResponseErrorMock
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.failure(response))
		}

		// When
		sut.viewDidLoad()

		// Then
		XCTAssertTrue(viewController.showLoaderIndicatorCalled)
		XCTAssertTrue(viewController.displayViewScreenTitleSectionsCalled)
		XCTAssertTrue(viewController.showErrorMessageTitleMessageCalled)
		XCTAssertTrue(viewController.hideLoaderIndicatorCalled)
	}

	func testPresenterSectionForIndexWhenValues() {
		// Given
		let response = populateSectionsAndReturnResponse()
		let index = 0
		let expectedValue = response.userProfile?.pinnedItems.nodes?.first!?.asRepository

		// When
		let section = sut.section(for: index)

		// Then
		XCTAssertNotNil(section)
		XCTAssertEqual(expectedValue?.name, section?.items[safe: index]?.repoName)
	}

	func testPresenterSectionForIndexWhenNoValues() {
		// Given
		let index = 0
		
		// When
		let section = sut.section(for: index)

		// Then
		XCTAssertNil(section)
	}

	func testPreseterUserProfileWhenValues() {
		// Given
		let response = populateSectionsAndReturnResponse()
		let expectedValue = response.userProfile?.name

		// When
		let userHeaderProfile = sut.userProfileInfo()

		// Then
		XCTAssertNotNil(userHeaderProfile)
		XCTAssertEqual(expectedValue, userHeaderProfile.name)
	}

	func testPreseterUserProfileWhenNoValues() {
		// Given
		let expectedValue = HeaderViewModel.placeholder.name

		// When
		let userHeaderProfile = sut.userProfileInfo()

		// Then
		XCTAssertNotNil(userHeaderProfile)
		XCTAssertEqual(expectedValue, userHeaderProfile.name)
	}

	func testPresenterReloadDataWhenSuccess() {
		// Given
		let response = UserProfileQueryResponse(userProfile: userProfileResponseMock, graphQLError: nil)
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.success(response))
		}

		// When
		sut.reloadData()

		// Then
		XCTAssertFalse(viewController.showLoaderIndicatorCalled)
		XCTAssertTrue(viewController.reloadDataWithCalled)
		XCTAssertFalse(viewController.showErrorMessageTitleMessageCalled)
		XCTAssertFalse(viewController.hideLoaderIndicatorCalled)
	}

	func testPresenterReloadDataWhenFailure() {
		// Given
		let response = userProfileResponseErrorMock
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.failure(response))
		}

		// When
		sut.reloadData()

		// Then
		XCTAssertFalse(viewController.showLoaderIndicatorCalled)
		XCTAssertTrue(viewController.reloadDataWithCalled)
		XCTAssertTrue(viewController.showErrorMessageTitleMessageCalled)
		XCTAssertTrue(viewController.hideLoaderIndicatorCalled)
	}

	func testPresenterRepositoryIDWhenValues() {
		// Given
		let response = populateSectionsAndReturnResponse()
		let indexPath = IndexPath(row: 0, section: 0)
		let expectedValue = response.userProfile?.pinnedItems.nodes?.first!?.asRepository

		// When
		sut.repositoryId(indexPath: indexPath)

		// Then
		XCTAssertTrue(viewController.repositoryItemDidFindItemCalled)
		XCTAssertEqual(expectedValue?.name, viewController.repositoryItemDidFindItemReceivedItem?.repoName)
	}

	func testPresenterRepositoryIDWhenNoValues() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)

		// When
		sut.repositoryId(indexPath: indexPath)

		// Then
		XCTAssertFalse(viewController.repositoryItemDidFindItemCalled)
	}
}

private extension ProfilePresenterTests {
	var userProfileResponseMock: UserProfile {
		UserProfileFistures.userProfile
	}

	var userProfileResponseErrorMock: Error {
		UserProfileFistures.repositoryError
	}

	func populateSectionsAndReturnResponse() -> UserProfileQueryResponse {
		let response = UserProfileQueryResponse(userProfile: userProfileResponseMock, graphQLError: nil)
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.success(response))
		}
		sut.viewDidLoad()
		return response
	}
}
