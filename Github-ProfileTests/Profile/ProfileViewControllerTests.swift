//
// ProfileViewControllerTests.swift
// Github-ProfileTests
//
// Created by Marcos González on 2021.
// 
//

import XCTest
@testable import Github_Profile

final class ProfileViewControllerTests: XCTestCase {
	private var sut: ProfileViewController!
	private var presenterMock: MockProfilePresenting!
	private var viewController: MockProfileViewDisplaying!

	override func setUp() {
		presenterMock = MockProfilePresenting()
		sut = ProfileViewController(presenter: presenterMock)
	}

	override func tearDown(){
		presenterMock = nil
		sut = nil
	}

	func test_presenterCalled_whenViewDidLoad() {
		// Given
		appearanceTransition()

		// When
		sut.viewDidLoad()

		// Then
		XCTAssertTrue(presenterMock.loadUserProfileDataCalled)
	}

	func test_presenterCalled_whenPullToRefresh() {
		// Given
		sut.loadViewIfNeeded()

		// When
		sut.refresh()

		// Then
		XCTAssertTrue(presenterMock.reloadDataCalled)
	}

	func test_presenterCalled_whenItemDidSelect() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)
		sut.loadViewIfNeeded()

		// When
		sut.requestRepositoy(indexPath: indexPath)

		// Then
		XCTAssertTrue(presenterMock.repositoryIdIndexPathCalled)
		XCTAssertEqual(indexPath, presenterMock.repositoryIdIndexPathReceivedIndexPath)
	}

	func test_presenterCalled_whenCreateLayout() {
		// Given
		let index = 0
		sut.loadViewIfNeeded()

		// When
		_ = sut.requestSectionFor(index: index)

		// Then
		XCTAssertTrue(presenterMock.sectionForCalled)
	}

	func test_presenterCalled_whenUserProfileNeeded() {
		// Given
		sut.loadViewIfNeeded()

		// When
		_ = sut.requestUserProfileInfo()

		// Then
		XCTAssertTrue(presenterMock.userProfileInfoCalled)
	}

	func test_presenterCalled_whenUpdateProfileNameNeeded() {
		// Given
		let userProfile = "AnyUserProfile"
		sut.loadViewIfNeeded()

		// When
		sut.requestUserProfile(userProfile: userProfile)

		// Then
		XCTAssertTrue(presenterMock.updateProfileNameAndLoadDataNewProfileNameCalled)
		XCTAssertEqual(presenterMock.updateProfileNameAndLoadDataNewProfileNameReceivedNewProfileName, userProfile)
	}

	func test_presenterCalled_whenUpdateCredentialsNeeded() {
		// Given
		let credentials = "AnyCredentials"
		sut.loadViewIfNeeded()

		// When
		sut.requestUserProfile(credentials: credentials)

		// Then
		XCTAssertTrue(presenterMock.updateCredentialsAndLoadDataNewCredentialsCalled)
		XCTAssertEqual(presenterMock.updateCredentialsAndLoadDataNewCredentialsReceivedNewCredentials, credentials)
	}
}

private extension ProfileViewControllerTests {
	var sectionHeaderVM: SectionHeaderViewModel {
		.init(title: "Section Title", actionTitle: "View all")
	}

	var sections: [Section] {
		[
			Section(
				   type: .pinned,
				   headerViewModel: sectionHeaderVM,
				   items: []
			   )
		]
	}

	func appearanceTransition(appearing: Bool = true) {
		sut.beginAppearanceTransition(appearing, animated: false)
		sut.endAppearanceTransition()
	}
}
