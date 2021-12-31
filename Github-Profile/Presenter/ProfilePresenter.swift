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
	func section(for index: Int) -> Section?
	func userProfileInfo() -> HeaderViewModel
	func reloadData()
	func repositoryId(indexPath: IndexPath)
}

final class ProfilePresenter: ProfilePresentable {
	weak var view: ProfileViewDisplayale?

	private var userProfile: UserProfile?
	private var sections: [Section] = []
	private let profileRepository: ProfileRepositoryProtocol

	init(repository: ProfileRepositoryProtocol) {
		profileRepository = repository
	}
	
	func viewDidLoad() {
		view?.showLoaderIndicator()
		getUserFullProfile { [weak self] in
			guard let self = self else { return }

			self.view?.hideLoaderIndicator()
			self.view?.displayView(
				screenTitle: "profile_summary_title".localized,
				sections: self.sections
			)
		}
	}

	func section(for index: Int) -> Section? {
		sections[safe: index]
	}

	func userProfileInfo() -> HeaderViewModel {
		guard let userProfileInfo = userProfile else {
			return .placeholder
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
		getUserFullProfile { [weak self] in
			guard let self = self else { return }
			self.view?.reloadData(with: self.sections)
		}
	}

	func repositoryId(indexPath: IndexPath) {
		guard let section = sections[safe: indexPath.section],
		let item = section.items[safe: indexPath.row] else { return }
		view?.repositoryItemDidFind(item: item)
	}
}

private extension ProfilePresenter {
	func getUserFullProfile(completion: @escaping () -> Void) {
		profileRepository.userProfileRepositories(
			username: QueryItems.profileToFetch
		) { [weak self] result in
			guard let self = self else { return }

			switch result {
			case let .success(response):
				if let userProfileInfo = response.userProfile {
					let createdSections = self.createSections(userProfile: userProfileInfo)
					self.userProfile = userProfileInfo
					self.sections = createdSections
				}

				if let graphqlError = response.graphQLError as? RepositoryError {
					var errorMessage: String
					switch graphqlError {
					case let .generic(error):
						errorMessage = error.localizedDescription
					case let .graphQL(messsage):
						errorMessage = messsage
					}

					self.presentError(
						title: "general_alert_graphQLerror_title".localized,
						message: errorMessage
					)
				}
				completion()
			case let .failure(error):
				self.presentError(
					title: "general_alert_error_title".localized,
					message: error.localizedDescription
				)
				completion()
			}
		}
	}

	func createSections(userProfile: UserProfile) -> [Section] {
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

		if let nodesType = items as? [PinnedReposNode] {
			repoItems = nodesType.compactMap { item in
				guard let repo = item.asRepository else { return nil }
				var langName: String = "profile_repository_language_placeholder".localized
				var langColor: String = ""
				if let first = repo.languages?.nodes?.first,
				   let language = first {
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
		} else if let nodesType = items as? [TopReposNode] {
			repoItems = nodesType.compactMap { repo in
				var langName: String = "profile_repository_language_placeholder".localized
				var langColor: String = ""
				if let first = repo.languages?.nodes?.first,
				   let language = first {
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
		} else if let nodesType = items as? [StarredReposNode] {
			repoItems = nodesType.compactMap { repo in
				var langName: String = "profile_repository_language_placeholder".localized
				var langColor: String = ""
				if let first = repo.languages?.nodes?.first,
				   let language = first {
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

	func presentError(title: String, message: String) {
		DLog("Error: \(message)")
		view?.hideLoaderIndicator()
		view?.showErrorMessage(title: title, message: message)
	}
}
