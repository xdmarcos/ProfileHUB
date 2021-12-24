// 
// ProfilePresenter.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

protocol ProfilePresentable {
	func viewDidLoad()
	func section(for index: Int) -> Section
	func reloadData()
}

final class ProfilePresenter: ProfilePresentable {
	weak var view: ProfileViewDisplayale?
	private var sections: [Section] = [
		Section(
			type: .pinned,
			headerViewModel: .init(title: "Pinned", actionTitle: "View all"),
			items: Repository.examplesPinned
		),
		Section(
			type: .top,
			headerViewModel: .init(title: "Top repositories", actionTitle: "View all"),
			items: Repository.examplesTop
		),
		Section(
			type: .starred,
			headerViewModel: .init(title: "Starred repositories", actionTitle: "View all"),
			items: Repository.examplessStarred
		)
	]

	func viewDidLoad() {
		view?.reloadData(with: sections)
	}

	func section(for index: Int) -> Section {
		sections[index]
	}

	func reloadData() {
		// fetch data and reload
	}
}
