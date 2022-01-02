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
				title = "profile_sections_title_pinned".localized
			case .top:
				title = "profile_sections_title_top".localized
			case .starred:
				title = "profile_sections_title_starred".localized
			}

			return title
		}

		var actionTitle: String {
			var actionTitle: String
			switch self {
			case .pinned:
				actionTitle = "profile_sections_pinned_action_title".localized
			case .top:
				actionTitle = "profile_sections_top_action_title".localized
			case .starred:
				actionTitle = "profile_sections_starred_action_title".localized
			}

			return actionTitle
		}
	}

	let id: UUID = UUID()
	let type: SectionType
	let headerViewModel: SectionHeaderViewModel
	let items: [Repository]
}
