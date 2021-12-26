// 
// Section.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

struct Section: Identifiable, Hashable {
	enum SectionType: String {
		case pinned
		case top
		case starred

		var title: String {
			var title: String
			switch self {
			case .pinned:
				title = "Pinned"
			case .top:
				title = "Top repositories"
			case .starred:
				title = "Starred repositories"
			}

			return title
		}

		var actionTitle: String {
			var actionTitle: String
			switch self {
			case .pinned:
				actionTitle = "View all"
			case .top:
				actionTitle = "View all"
			case .starred:
				actionTitle = "View all"
			}

			return actionTitle
		}
	}

	let id: UUID = UUID()
	let type: SectionType
	let headerViewModel: SectionHeaderViewModel
	let items: [Repository]
}
