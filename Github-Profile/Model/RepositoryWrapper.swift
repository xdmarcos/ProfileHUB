//
// RepositoryWrapper.swift
// Github-Profile
//
// Created by Marcos González on 2022.
// 
//

import Foundation

protocol RepositoryWrapper {
	var id: String { get }
	var username: String { get }
	var userImageUrl: String { get }
	var repoName: String { get }
	var repoDescription: String { get }
	var stars: String { get }
	var language: String { get }
	var languageColor: String { get }
}
