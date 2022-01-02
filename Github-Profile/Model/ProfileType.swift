//
// ProfileType.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

typealias UserProfile = UserProfileReposQuery.Data.User
typealias PinnedReposNode = UserProfileReposQuery.Data.User.PinnedItem.Node
typealias TopReposNode = UserProfileReposQuery.Data.User.TopRepository.Node
typealias StarredReposNode = UserProfileReposQuery.Data.User.StarredRepository.Node
typealias ProfileCompletion = (Result<UserProfileQueryResponse, Error>) -> Void
typealias PinnedReposNodeAsRepo = UserProfileReposQuery.Data.User.PinnedItem.Node.AsRepository

extension PinnedReposNodeAsRepo: RepositoryWrapper {
	var username: String {
		owner.login
	}

	var userImageUrl: String {
		owner.avatarUrl
	}

	var repoName: String {
		name
	}

	var repoDescription: String {
		description ?? ""
	}

	var stars: String {
		String(stargazerCount)
	}

	var language: String {
		var lang = ""
		if let first = languages?.nodes?.first,
		   let language = first?.name {
			lang = language
		}

		return lang
	}

	var languageColor: String {
		var langColor = "#FFA036"
		if let first = languages?.nodes?.first,
		   let languageColor = first?.color {
			langColor = languageColor
		}

		return langColor
	}
}

extension TopReposNode: RepositoryWrapper {
	var username: String {
		owner.login
	}

	var userImageUrl: String {
		owner.avatarUrl
	}

	var repoName: String {
		name
	}

	var repoDescription: String {
		description ?? ""
	}

	var stars: String {
		String(stargazerCount)
	}

	var language: String {
		var lang = ""
		if let first = languages?.nodes?.first,
		   let language = first?.name {
			lang = language
		}

		return lang
	}

	var languageColor: String {
		var langColor = "#FFA036"
		if let first = languages?.nodes?.first,
		   let languageColor = first?.color {
			langColor = languageColor
		}

		return langColor
	}
}

extension StarredReposNode: RepositoryWrapper {
	var username: String {
		owner.login
	}

	var userImageUrl: String {
		owner.avatarUrl
	}

	var repoName: String {
		name
	}

	var repoDescription: String {
		description ?? ""
	}

	var stars: String {
		String(stargazerCount)
	}

	var language: String {
		var lang = ""
		if let first = languages?.nodes?.first,
		   let language = first?.name {
			lang = language
		}

		return lang
	}

	var languageColor: String {
		var langColor = "#FFA036"
		if let first = languages?.nodes?.first,
		   let languageColor = first?.color {
			langColor = languageColor
		}

		return langColor
	}
}
