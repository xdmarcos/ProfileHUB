// 
// ProfilePresenter.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation
import Apollo

protocol ProfilePresentable {
	func viewDidLoad()
	func section(for index: Int) -> Section
	func userProfileInfo() -> HeaderViewModel
	func reloadData()
}

final class ProfilePresenter: ProfilePresentable {
	weak var view: ProfileViewDisplayale?

	private static let userToFetch = "xdmarcos"
	private static var userProfileInfoTemplate: HeaderViewModel {
		HeaderViewModel(
			name: "Name",
			username: "username",
			userImageUrl: "",
			email: "email address",
			following: "-",
			followers: "-"
		)
	}
	private var userProfile: UserProfileReposQuery.Data.User?
	private var sections: [Section] = []
	private let profileRepository: ProfileRepositoryProtocol

	init(repository: ProfileRepositoryProtocol) {
		profileRepository = repository
	}
	
	func viewDidLoad() {
		getSections { [weak self] result in
			guard let self = self,
				  let newSections = try? result.get() else { return }

			self.sections = newSections
			self.view?.displayView(with: newSections)
		}
	}

	func section(for index: Int) -> Section {
		sections[index]
	}

	func userProfileInfo() -> HeaderViewModel {
		guard let userProfileInfo = userProfile else {
			return Self.userProfileInfoTemplate
		}

		return HeaderViewModel(
			name: userProfileInfo.name ?? "--",
			username: userProfileInfo.login,
			userImageUrl: userProfileInfo.avatarUrl,
			email: userProfileInfo.email,
			following: String(userProfileInfo.following.totalCount),
			followers: String(userProfileInfo.followers.totalCount)
		)
	}

	func reloadData() {
		// fetch data and reload
	}
}

private extension ProfilePresenter {
	func getSections(completion: @escaping (Result<[Section], Error>) -> Void) {
		profileRepository.userProfileRepositories(
			username: Self.userToFetch) { [weak self] result in
				guard let self = self else { return }

				switch result {
				case let .success(response):
					if let userProfileInfo = response.userProfile {
						self.userProfile = userProfileInfo

						let sections = self.createSections(userProfile: userProfileInfo)
						completion(.success(sections))
					}

					if let graphqlError = response.graphQLError as? RepositoryError {
						var errorMessage: String
						switch graphqlError {
						case let .generic(error):
							errorMessage = error.localizedDescription
						case let .graphQL(messsage):
							errorMessage = messsage
						}

						print("GraphQL Error: \(errorMessage)")
					}
				case let .failure(error):
					print("Error: \(error.localizedDescription)")
					completion(.failure(error))
				}
			}
	}

	func createSections(userProfile: UserProfileReposQuery.Data.User) -> [Section] {
		var sections: [Section] = []

		if let pinned = userProfile.pinnedItems.nodes {
			let pinnedSection = createSection(sectionType: .pinned, nodes: pinned)
			sections.append(pinnedSection)
		}

		if let top = userProfile.topRepositories.nodes {
			let topSection = createSection(sectionType: .top, nodes: top)
			sections.append(topSection)
		}

		if let starred = userProfile.starredRepositories.nodes {
			let starredSection = createSection(sectionType: .starred, nodes: starred)
			sections.append(starredSection)
		}

		return sections
	}

	func createSection<T: GraphQLSelectionSet>(sectionType: Section.SectionType, nodes: [T?]) -> Section {
		let sectionHeader = SectionHeaderViewModel(
			title: sectionType.title,
			actionTitle: sectionType.actionTitle
		)

		let items = createRepoList(items: nodes)

		return Section(
			type: sectionType,
			headerViewModel: sectionHeader,
			items: items
		)
	}

	func createRepoList<T: GraphQLSelectionSet>(items: [T?]) -> [Repository] {
		var repoItems: [Repository] = []

		if let nodesType = items as? [UserProfileReposQuery.Data.User.PinnedItem.Node] {
			repoItems = nodesType.compactMap { item in
				guard let repo = item.asRepository else { return nil }
				var langName: String = ""
				var langColor: String = ""
				if let first = repo.languages?.nodes?.first, let language = first {
					langName = language.name
					langColor = language.color ?? "#FFA036"
				}

				return Repository(
					username: repo.owner.login,
					userImageUrl:  repo.owner.avatarUrl,
					repoName: repo.name,
					repoDescription: repo.description ?? "",
					stars: String(repo.stargazerCount),
					language: langName,
					languageColor: langColor
				)
			}
		} else if let nodesType = items as? [UserProfileReposQuery.Data.User.TopRepository.Node] {
			repoItems = nodesType.compactMap { repo in
				var langName: String = ""
				var langColor: String = ""
				if let first = repo.languages?.nodes?.first, let language = first {
					langName = language.name
					langColor = language.color ?? "#FFA036"
				}

				return Repository(
					username: repo.owner.login,
					userImageUrl:  repo.owner.avatarUrl,
					repoName: repo.name,
					repoDescription: repo.description ?? "",
					stars: String(repo.stargazerCount),
					language: langName,
					languageColor: langColor
				)
			}
		} else if let nodesType = items as? [UserProfileReposQuery.Data.User.StarredRepository.Node] {
			repoItems = nodesType.compactMap { repo in
				var langName: String = ""
				var langColor: String = ""
				if let first = repo.languages?.nodes?.first, let language = first {
					langName = language.name
					langColor = language.color ?? "#FFA036"
				}

				return Repository(
					username: repo.owner.login,
					userImageUrl:  repo.owner.avatarUrl,
					repoName: repo.name,
					repoDescription: repo.description ?? "",
					stars: String(repo.stargazerCount),
					language: langName,
					languageColor: langColor
				)
			}
		}

		return repoItems
	}
}
