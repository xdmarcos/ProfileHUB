//
// ProfileViewController+FlowLayout.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

// MARK: - Compositional flow layout

extension ProfileViewController {
	private enum ViewTraits {
		static let itemEstimatedHeight: CGFloat = 164
		static let pinnedItems: CGFloat = 3
		static let verticalSectionEstimatedHeight: CGFloat = (itemEstimatedHeight + commonSpacing) * pinnedItems
		static let sectionHeaderEstimatedHeight: CGFloat = 40
		static let headerEstimatedHeight: CGFloat = 230
		static let viewBottomMargin: CGFloat = 25
		static let commonSpacing: CGFloat = 16
		static let interSectionSpacing: CGFloat = 24
		static let carouselItemWidthPercentage: CGFloat = 0.53
	}
	
	func createCompositionalLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
			guard let self = self,
				  let section = self.requestSectionFor(index: sectionIndex) else { return nil }

			switch section.type {
			case .pinned:
				return self.createVerticalSection(using: section)
			default:
				return self.createHorizontalSection(using: section)

			}
		}

		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.interSectionSpacing = ViewTraits.interSectionSpacing
		let boundaryHeader = createBoundaryHeader()
		config.boundarySupplementaryItems = [boundaryHeader]

		layout.configuration = config

		return layout
	}

	private func createVerticalSection(using section: Section) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1 / ViewTraits.pinnedItems)
		)

		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: ViewTraits.commonSpacing,
			bottom: ViewTraits.commonSpacing,
			trailing: ViewTraits.commonSpacing
		)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(ViewTraits.verticalSectionEstimatedHeight)
		)
		let layoutGroup = NSCollectionLayoutGroup.vertical(
			layoutSize: layoutGroupSize,
			subitems: [layoutItem]
		)

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)

		let layoutSectionHeader = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

		return layoutSection
	}

	private func createHorizontalSection(using section: Section) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)

		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: ViewTraits.commonSpacing,
			bottom: 0,
			trailing: 0
		)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(ViewTraits.carouselItemWidthPercentage),
			heightDimension: .estimated(ViewTraits.itemEstimatedHeight)
		)

		let layoutGroup = NSCollectionLayoutGroup.horizontal(
			layoutSize: layoutGroupSize,
			subitems: [layoutItem]
		)

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.orthogonalScrollingBehavior = .groupPaging

		let layoutSectionHeader = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

		var contentInsets: NSDirectionalEdgeInsets = .zero
		if case .starred = section.type {
			contentInsets.bottom = ViewTraits.viewBottomMargin
		}

		layoutSection.contentInsets = contentInsets

		return layoutSection
	}

	private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let layoutSectionHeaderSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(ViewTraits.sectionHeaderEstimatedHeight)
		)

		let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: layoutSectionHeaderSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .topLeading
		)
		layoutSectionHeader.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: ViewTraits.commonSpacing,
			bottom: 0,
			trailing: ViewTraits.commonSpacing
		)
		layoutSectionHeader.zIndex = 0
		return layoutSectionHeader
	}

	private func createBoundaryHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .estimated(ViewTraits.headerEstimatedHeight)
		)
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: HeaderView.supplementaryViewKind,
			alignment: .top
		)
		sectionHeader.pinToVisibleBounds = true

		return sectionHeader
	}
}
