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
	let userImage: UIImage
	let repoName: String
	let repoDescription: String
	let stars: String
	let language: String
}

// MARK: - Debug helpers
#if DEBUG
extension Repository {
	static let examplesPinned: [Repository] =
	[
		Repository(
			username: "xdmgazdev",
			userImage: UIImage(named: "octocat")!,
			repoName: "repoName_ios_1",
			repoDescription: "This is a repo with a very long long ong description",
			stars: "8",
			language: "Swift"
		),
		Repository(
			username: "xdmgazdev",
			userImage: UIImage(named: "octocat")!,
			repoName: "repoName_ios_2",
			repoDescription: "This is a repo with a very long long ong description",
			stars: "8",
			language: "Swift"
		),
		Repository(
			username: "xdmgazdev",
			userImage: UIImage(named: "octocat")!,
			repoName: "repoName_ios_3",
			repoDescription: "This is a repo with a very long long ong description",
			stars: "8",
			language: "Swift"
		)
	]

	static let examplesTop: [Repository] =
	[
		Repository(
			username: "xdmgazdev",
			userImage: UIImage(named: "octocat")!,
			repoName: "repoName_ios_1",
			repoDescription: "This is a repo with a very long long ong description",
			stars: "8",
			language: "Swift"
		),
		Repository(
			username: "xdmgazdev",
			userImage: UIImage(named: "octocat")!,
			repoName: "repoName_ios_2",
			repoDescription: "This is a repo with a very long long ong description",
			stars: "8",
			language: "Swift"
		)
	]

	static let examplessStarred: [Repository] =
	[
		Repository(
			username: "xdmgazdev",
			userImage: UIImage(named: "octocat")!,
			repoName: "repoName_ios_1",
			repoDescription: "This is a repo with a very long long ong description",
			stars: "8",
			language: "Swift"
		),
		Repository(
			username: "xdmgazdev",
			userImage: UIImage(named: "octocat")!,
			repoName: "repoName_ios_2",
			repoDescription: "This is a repo with a very long long ong description",
			stars: "8",
			language: "Swift"
		)
	]
}
#endif
