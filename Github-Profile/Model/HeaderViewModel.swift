// 
// ProfileViewModel.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

struct HeaderViewModel: Hashable {
	let name: String
	let username: String
	let userImageUrl: String
	let email: String
	let following: String
	let followers: String

	static var placeholder: HeaderViewModel {
		HeaderViewModel(
			name: "profile_header_name_placeholder".localized,
			username: "profile_header_username_placeholder".localized,
			userImageUrl: "",
			email: "profile_header_email_placeholder".localized,
			following: "-",
			followers: "-"
		)
	}
}
