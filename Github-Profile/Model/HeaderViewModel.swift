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

	// TODO: Localize
	static var placeholder: HeaderViewModel {
		HeaderViewModel(
			name: "Name",
			username: "username",
			userImageUrl: "",
			email: "email address",
			following: "-",
			followers: "-"
		)
	}
}
