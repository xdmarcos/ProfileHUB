//
// UserProfileFistures.swift
// Github-ProfileTests
//
// Created by Marcos González on 2021.
// 
//

import Foundation
@testable import Github_Profile

enum UserProfileFistures {
	static var follower: UserProfileReposQuery.Data.User.Follower = {
		.init(totalCount: 3)
	}()

	static var following: UserProfileReposQuery.Data.User.Following = {
		.init(totalCount: 7)
	}()

	static var pinnedLanguageNode: UserProfileReposQuery.Data.User.PinnedItem.Node.AsRepository.Language.Node = {
		.init(name: "Swift", color: "#FFA036")
	}()

	static var topLanguageNode: UserProfileReposQuery.Data.User.TopRepository.Node.Language.Node = {
		.init(name: "Swift", color: "#FFA036")
	}()

	static var starredLanguageNode: UserProfileReposQuery.Data.User.StarredRepository.Node.Language.Node = {
		.init(name: "Swift", color: "#FFA036")
	}()

	static var pinnedOwner: UserProfileReposQuery.Data.User.PinnedItem.Node.AsRepository.Owner = {
		.makeUser(avatarUrl: "PinnedAvatarURL", login: "PinnedOwner")
	}()

	static var topOwner: UserProfileReposQuery.Data.User.TopRepository.Node.Owner = {
		.makeUser(login: "TopOwner", avatarUrl: "TopAvatarURL")
	}()

	static var starredOwner: UserProfileReposQuery.Data.User.StarredRepository.Node.Owner = {
		.makeUser(login: "StarredOwner", avatarUrl: "StarredAvatarURL")
	}()

	static var pinnedNode: UserProfileReposQuery.Data.User.PinnedItem.Node = {
		.makeRepository(
			description: "A test Pinned repository",
			id: "AnyTestID",
			languages: .init(nodes: [pinnedLanguageNode]),
			name: "PinnedRepo",
			owner: pinnedOwner,
			stargazerCount: 8
		)
	}()

	static var topNode: UserProfileReposQuery.Data.User.TopRepository.Node = {
		.init(
			description: "A test Top repository",
			id: "AnyTestID",
			languages: .init(nodes: [topLanguageNode]),
			name: "TopRepo",
			owner: topOwner,
			stargazerCount: 10
		)
	}()

	static var starredNode: UserProfileReposQuery.Data.User.StarredRepository.Node = {
		.init(
			description: "A test Starred repository",
			id: "AnyTestID",
			languages: .init(nodes: [starredLanguageNode]),
			name: "StarredRepo",
			owner: starredOwner,
			stargazerCount: 5
		)
	}()

	static var pinned: UserProfileReposQuery.Data.User.PinnedItem = {
		.init(nodes: [pinnedNode])
	}()

	static var top: UserProfileReposQuery.Data.User.TopRepository = {
		.init(nodes: [topNode])
	}()

	static var starred: UserProfileReposQuery.Data.User.StarredRepository = {
		.init(nodes: [starredNode])
	}()

	static var userProfile: UserProfile = {
		UserProfile.init(
			avatarUrl: "",
			email: "email@address.com",
			followers: follower,
			following: following,
			id: "TestId",
			login: "username",
			name: "Test official name",
			pinnedItems: pinned,
			topRepositories: top,
			starredRepositories: starred)
	}()

	static let repositoryError: RepositoryError = {
		RepositoryError.graphQL(messsage: "RepositoryError: Test error message")
	}()

	static var userProfileQuerySuccessResponse: UserProfileQueryResponse = {
		.init(userProfile: userProfile, graphQLError: nil)
	}()
	static var userProfileQuerySuccessWithErrorResponse: UserProfileQueryResponse = {
		.init(userProfile: userProfile, graphQLError: repositoryError)
	}()

	static var userProfileQueryFailureResponse: Error = {
		repositoryError
	}()
}
