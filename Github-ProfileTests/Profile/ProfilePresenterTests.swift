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
	private var profileRepositoryMock: MockProfileRepository!
	private var viewController: MockProfileViewDisplaying!

    override func setUp() {
		profileRepositoryMock = MockProfileRepository()
		let mockConfig = Required(
			profileToFetch: .profileName("AnyProfileName"),
			personalAccessToken: .token("AnyToken"))
		sut = ProfilePresenter(repository: profileRepositoryMock, configuration: mockConfig)
		viewController = MockProfileViewDisplaying()
		sut.view = viewController
    }

    override func tearDown(){
        profileRepositoryMock = nil
		viewController = nil
		sut = nil
    }

	func testPresenter_loadUserProfileData_whenSuccess() {
		// Given
		let response = UserProfileQueryResponse(userProfile: userProfileResponseMock, graphQLError: nil)
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.success(response))
		}

		// When
		sut.loadUserProfileData()

		// Then
		XCTAssertTrue(viewController.showLoaderIndicatorCalled)
		XCTAssertTrue(viewController.displayViewScreenTitleSectionsCalled)
		XCTAssertFalse(viewController.showErrorMessageTitleMessageCalled)
		XCTAssertTrue(viewController.hideLoaderIndicatorCalled)
	}

	func testPresenter_loadUserProfileData_whenFailure() {
		// Given
		let response = userProfileResponseErrorMock
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.failure(response))
		}

		// When
		sut.loadUserProfileData()

		// Then
		XCTAssertTrue(viewController.showLoaderIndicatorCalled)
		XCTAssertFalse(viewController.displayViewScreenTitleSectionsCalled)
		XCTAssertTrue(viewController.showErrorMessageTitleMessageCalled)
		XCTAssertTrue(viewController.hideLoaderIndicatorCalled)
	}

	func testPresenter_sectionForIndex_whenValues() {
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

	func testPresenter_sectionForIndex_whenNoValues() {
		// Given
		let index = 0
		
		// When
		let section = sut.section(for: index)

		// Then
		XCTAssertNil(section)
	}

	func testPreseter_userProfile_whenValues() {
		// Given
		let response = populateSectionsAndReturnResponse()
		let expectedValue = response.userProfile?.name

		// When
		let userHeaderProfile = sut.userProfileInfo()

		// Then
		XCTAssertNotNil(userHeaderProfile)
		XCTAssertEqual(expectedValue, userHeaderProfile?.name)
	}

	func testPreseter_userProfile_whenNoValues() {
		// Given
		populateSectionsWithEmpty()

		// When
		let userHeaderProfile = sut.userProfileInfo()

		// Then
		XCTAssertNil(userHeaderProfile)
	}

	func testPresenter_reloadData_whenSuccess() {
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

	func testPresenter_reloadData_whenFailure() {
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

	func testPresenter_repositoryId_whenValues() {
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

	func testPresenter_repositoryId_whenNoValues() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)

		// When
		sut.repositoryId(indexPath: indexPath)

		// Then
		XCTAssertFalse(viewController.repositoryItemDidFindItemCalled)
	}

	func testPresenter_updateProfileName_whenValues() {
		// Given
		let profileName = "AnyProfileName"

		// When
		sut.updateProfileNameAndLoadData(newProfileName: profileName)

		// Then
		XCTAssertTrue(profileRepositoryMock.userProfileRepositoriesUsernameCompletionCalled)
		XCTAssertEqual(profileName, profileRepositoryMock.userProfileRepositoriesUsernameCompletionReceivedArguments?.username)
	}

	func testPresenter_updateCredentials_whenValues() {
		// Given
		let credentials = "NewCredentials"

		// When
		sut.updateCredentialsAndLoadData(newCredentials: credentials)

		// Then
		XCTAssertTrue(profileRepositoryMock.userProfileRepositoriesUsernameCompletionCalled)
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
		sut.loadUserProfileData()
		return response
	}

	func populateSectionsWithEmpty() {
		let response = userProfileResponseErrorMock
		profileRepositoryMock.userProfileRepositoriesUsernameCompletionClosure = { _, completion in
			completion(.failure(response))
		}
		sut.loadUserProfileData()
	}
}
