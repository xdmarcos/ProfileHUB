// 
// ProfilePresenter.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation
import Apollo
import KeyChain

protocol ProfilePresenting {
	func getUserProfile()
	func section(for index: Int) -> Section?
	func userProfileInfo() -> HeaderViewModel?
	func reloadData()
	func repositoryId(indexPath: IndexPath)
	func updateProfileName(newProfileName: String)
	func updateCredentials(newCredentials: String)
}

final class ProfilePresenter: ProfilePresenting {
	weak var view: ProfileViewDisplaying?

	private var userProfile: UserProfile?
	private var sections: [Section] = []
	private var profileNameToFetch: Required.Item
	private var credentials: Required.Item
	private let profileRepository: ProfileRepositoryProtocol

	init(repository: ProfileRepositoryProtocol, configuration: Required) {
		profileRepository = repository
		profileNameToFetch = configuration.profileToFetch
		credentials = configuration.personalAccessToken
	}
	
	func getUserProfile() {
		updateCredentialsWithStoredValueIfNeeded()

		if shouldContinueAfterCheckRequiredItems() {
			view?.showLoaderIndicator()
			getUserFullProfile(profileName: profileNameToFetch.value) { [weak self] error in
				guard let self = self,
				error == nil else { return }

				self.view?.hideLoaderIndicator()
				self.view?.displayView(
					screenTitle: "profile_summary_title".localized,
					sections: self.sections
				)
				self.saveCredentials(token: self.credentials.value)
			}
		}
	}

	func section(for index: Int) -> Section? {
		sections[safe: index]
	}

	func userProfileInfo() -> HeaderViewModel? {
		guard let userProfileInfo = userProfile else { return nil}

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
		getUserFullProfile(profileName: profileNameToFetch.value) { [weak self] _ in
			guard let self = self else { return }
			self.view?.reloadData(with: self.sections)
		}
	}

	func repositoryId(indexPath: IndexPath) {
		guard let section = sections[safe: indexPath.section],
		let item = section.items[safe: indexPath.row] else { return }
		view?.repositoryItemDidFind(item: item)
	}

	func updateProfileName(newProfileName: String) {
		profileNameToFetch = .profileName(newProfileName)
	}

	func updateCredentials(newCredentials: String) {
		credentials = .token(newCredentials)
	}
}

private extension ProfilePresenter {
	func getUserFullProfile(profileName: String, completion: @escaping (Error?) -> Void) {
		profileRepository.userProfileRepositories(
			username: profileName
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
					completion(graphqlError)
				} else {
					completion(nil)
				}
			case let .failure(error):
				if let serviceError = error as? GraphQLServiceError {
					if serviceError.statusCode == Constants.unAuthorizedCode {
						self.requestNewCredentials()
					} else {
						self.presentError(
							title: "general_alert_error_title".localized,
							message: serviceError.localizedDescription
						)
					}
				} else {
					self.presentError(
						title: "general_alert_error_title".localized,
						message: error.localizedDescription
					)
				}
				completion(error)
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
				return createRepository(repoInfo: repo)
			}
		} else if let nodesType = items as? [TopReposNode] {
			repoItems = nodesType.compactMap { repo in
				createRepository(repoInfo: repo)
			}
		} else if let nodesType = items as? [StarredReposNode] {
			repoItems = nodesType.compactMap { repo in
				createRepository(repoInfo: repo)
			}
		}

		return repoItems
	}

	func createRepository(repoInfo: RepositoryWrapper) -> Repository? {
		Repository(
			username: repoInfo.username,
			userImageUrl: repoInfo.userImageUrl,
			repoName: repoInfo.repoName,
			repoDescription: repoInfo.repoDescription,
			stars: repoInfo.stars,
			language: repoInfo.language,
			languageColor: repoInfo.languageColor
		)
	}

	func presentError(title: String, message: String) {
		DLog("Error: \(message)")
		view?.hideLoaderIndicator()
		view?.showErrorMessage(title: title, message: message)
	}

	func shouldContinueAfterCheckRequiredItems() -> Bool {
		if !isValidQueryRequiredItem(item: credentials.value) {
			requestNewCredentials()
			return false
		} else if !isValidQueryRequiredItem(item: profileNameToFetch.value) {
			requestNewUserProfile()
			return false
		}

		return true
	}

	func isValidQueryRequiredItem(item: String) -> Bool {
		!item.starts(with: "***_") && !item.isEmpty
	}

	func createProfileNameForm() -> FormViewModel {
		.init(
			title: "form_general_alert_info_title".localized,
			message: "form_userprofile_alert_requirement_description".localized
		)
	}

	func createCredentialsForm() -> FormViewModel {
		.init(
			title: "form_general_alert_info_title".localized,
			message: "form_pat_alert_description".localized
		)
	}

	func requestNewCredentials() {
		view?.hideLoaderIndicator()
		removeStoredCredentials()
		view?.displayForm(for: credentials, viewModel: createCredentialsForm())
	}

	func requestNewUserProfile() {
		view?.displayForm(for: profileNameToFetch, viewModel: createProfileNameForm())
	}

	func updateCredentialsWithStoredValueIfNeeded() {
		guard  let storedCredentials = validStoredCredentials(),
		   storedCredentials != credentials.value  else {
			   return
		}
		updateCredentials(newCredentials: storedCredentials)
	}

	func validStoredCredentials() -> String? {
		guard let stored = KeyChain.string(forKey: Constants.keyChainCredentialsKey),
			  isValidQueryRequiredItem(item: stored) else { return nil}
		return stored
	}

	func saveCredentials(token: String) {
		KeyChain.set(value: token, forKey: Constants.keyChainCredentialsKey)
	}

	func removeStoredCredentials() {
		KeyChain.removeValue(forKey: Constants.keyChainCredentialsKey)
	}
}
