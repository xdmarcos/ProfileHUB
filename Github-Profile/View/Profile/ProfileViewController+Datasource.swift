//
// ProfileViewController+Datasource.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit
import CommonUI

// MARK: - CollectionView diffable datasource
extension ProfileViewController {
	func createDatasource() -> UICollectionViewDiffableDataSource<Section, Repository> {
		let datasource = UICollectionViewDiffableDataSource<Section, Repository>(collectionView: sceneView.profileCollectionView) { [weak self] collectionView, indexPath, repository in
			guard let self = self,
				  let section = self.requestSectionFor(index: indexPath.section) else { return nil }

			switch section.type {
			default:
				return self.configure(
					RepositoryTileCell.self,
					with: repository as RepositoryTileCell.ViewModel,
					for: indexPath
				)
			}
		}

		datasource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			guard let self = self else { return nil }

			if kind == HeaderView.supplementaryViewKind {
				guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: HeaderView.reuseIdentifier,
					for: indexPath
				) as? HeaderView else {
					return nil
				}

				guard let headerViewModel = self.requestUserProfileInfo() else { return sectionHeader }
				
				sectionHeader.configure(viewModel: headerViewModel)
				return sectionHeader
			} else {
				guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: SectionHeaderView.reuseIdentifier,
					for: indexPath
				) as? SectionHeaderView else {
					return nil
				}

				guard let section = self.requestSectionFor(index: indexPath.section) else { return nil }

				sectionHeader.configure(viewModel: section.headerViewModel)
				return sectionHeader
			}
		}

		return datasource
	}

	private func configure<T: ViewCellConfigurable>(
		_ cellType: T.Type,
		with viewModel: T.ViewModel,
		for indexPath: IndexPath) -> T {
			guard let cell = sceneView.profileCollectionView.dequeueReusableCell(
				withReuseIdentifier: cellType.reuseIdentifier,
				for: indexPath
			) as? T else {
				fatalError("Unable to dequeue \(cellType)")
			}

			cell.configure(viewModel: viewModel)
			return cell
		}
}
