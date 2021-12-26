// 
// Repository.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

struct Repository: Identifiable, Hashable {
	let id: UUID = UUID()
	let username: String
	let userImageUrl: String
	let repoName: String
	let repoDescription: String
	let stars: String
	let language: String
	let languageColor: String
}
