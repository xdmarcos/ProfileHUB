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
	private var presenterMock: MockProfilePresentable!
	private var viewController: MockProfileViewDisplayable!

	override func setUp() {
		presenterMock = MockProfilePresentable()
		sut = ProfileViewController(presenter: presenterMock)
	}

	override func tearDown(){
		presenterMock = nil
		sut = nil
	}

	func testPresentedCalledWhenViewDidLoad() {
		// Given
		appearanceTransition()

		// When
		sut.viewDidLoad()

		// Then
		XCTAssertTrue(presenterMock.viewDidLoadCalled)
	}

	func testPresentedCalledWhenPullToRefresh() {
		// Given
		sut.loadViewIfNeeded()

		// When
		sut.refresh()

		// Then
		XCTAssertTrue(presenterMock.reloadDataCalled)
	}

	func testPresentedCalledWhenItemDidSelect() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)
		sut.loadViewIfNeeded()

		// When
		sut.requestRepositoy(indexPath: indexPath)

		// Then
		XCTAssertTrue(presenterMock.repositoryIdIndexPathCalled)
		XCTAssertEqual(indexPath, presenterMock.repositoryIdIndexPathReceivedIndexPath)
	}

	func testPresentedCalledWhenCreateLayout() {
		// Given
		let index = 0
		sut.loadViewIfNeeded()

		// When
		_ = sut.requestSectionFor(index: index)

		// Then
		XCTAssertTrue(presenterMock.sectionForCalled)
	}

	func testPresentedCalledWhenSUserProlineNeeded() {
		// Given
		presenterMock.userProfileInfoReturnValue = HeaderViewModel.placeholder
		sut.loadViewIfNeeded()

		// When
		_ = sut.requestUserProfileInfo()

		// Then
		XCTAssertTrue(presenterMock.userProfileInfoCalled)
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
