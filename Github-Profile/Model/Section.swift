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
	}

	let id: UUID = UUID()
	let type: SectionType
	let headerViewModel: SectionHeaderViewModel
	let items: [Repository]
}
