// 
// ProfileViewController.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 

import UIKit

protocol ProfileViewDisplayale: AnyObject {
	func displayView(with sections: [Section])
	func reloadData(with sections: [Section])
}

final class ProfileViewController: UIViewController {
	private enum ViewTraits {
		static let verticalSectionEstimatedHeight: CGFloat = 630
		static let horizontalSectionEstimatedHeight: CGFloat = 210
		static let sectionHeaderEstimatedHeight: CGFloat = 80
		static let headerEstimatedHeight: CGFloat = 210
		static let viewBottomMargin: CGFloat = 25
		static let commonSpacing: CGFloat = 15
		static let interSectionSpacing: CGFloat = 30
	}

	private let presenter: ProfilePresentable
	private let sceneView = ProfileView()
	private var refreshControl = UIRefreshControl()
	private var dataSource: UICollectionViewDiffableDataSource<Section, Repository>?

	public init(presenter: ProfilePresentable) {
		self.presenter = presenter

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View lifecycle

	override func loadView() {
		view = sceneView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
		presenter.viewDidLoad()
	}

	// MARK: Actions

	@objc func refresh(_: AnyObject) {
		presenter.reloadData()
		refreshControl.beginRefreshing()
	}
}

// MARK: - Setup UI components
private extension ProfileViewController {
	func setupUI() {
		title = "profile_summary_title"// TODO: .localized

		refreshControl.attributedTitle = NSAttributedString(string: "profile_refresh_title")// TODO: .localized)
		refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
		sceneView.profileCollectionView.refreshControl = refreshControl

		sceneView.profileCollectionView.setCollectionViewLayout(
			createCompositionalLayout(),
			animated: false
		)
		sceneView.profileCollectionView.register(
			SectionHeaderView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: SectionHeaderView.reuseIdentifier
		)
		sceneView.profileCollectionView.register(
			HeaderView.self,
			forSupplementaryViewOfKind: HeaderView.supplementaryViewKind,
			withReuseIdentifier: HeaderView.reuseIdentifier
		)
		sceneView.profileCollectionView.register(
			RepositoryTileCell.self,
			forCellWithReuseIdentifier: RepositoryTileCell.reuseIdentifier
		)
	}
}

// MARK: - Compositional flow layout
private extension ProfileViewController {
	func createCompositionalLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
			guard let self = self,
				  let section = self.presenter.section(for: sectionIndex) else { return nil }

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

	func createVerticalSection(using section: Section) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(0.33)
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

	func createHorizontalSection(using section: Section) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)

		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: 0,
			bottom: 0,
			trailing: ViewTraits.commonSpacing
		)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.7),
			heightDimension: .estimated(ViewTraits.horizontalSectionEstimatedHeight)
		)

		let layoutGroup = NSCollectionLayoutGroup.horizontal(
			layoutSize: layoutGroupSize,
			subitems: [layoutItem]
		)

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.orthogonalScrollingBehavior = .groupPaging

		let layoutSectionHeader = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

		var contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: ViewTraits.commonSpacing,
			bottom: 0,
			trailing: 0
		)
		if case .starred = section.type {
			contentInsets = NSDirectionalEdgeInsets(
				top: 0,
				leading: ViewTraits.commonSpacing,
				bottom: ViewTraits.viewBottomMargin,
				trailing: 0
			)
		}

		layoutSection.contentInsets = contentInsets

		return layoutSection
	}

	func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let layoutSectionHeaderSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(ViewTraits.sectionHeaderEstimatedHeight)
		)

		let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: layoutSectionHeaderSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top
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

	func createBoundaryHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
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

// MARK: - CollectionView diffable datasource
private extension ProfileViewController {
	func createDatasource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Repository>(collectionView: sceneView.profileCollectionView) { [weak self] collectionView, indexPath, repository in
			guard let self = self,
				  let section = self.presenter.section(for: indexPath.section) else { return nil }

			switch section.type {
			default:
				return self.configure(
					RepositoryTileCell.self,
					with: repository as RepositoryTileCell.ViewModel,
					for: indexPath
				)
			}
		}

		dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			guard let self = self else { return nil }

			if kind == HeaderView.supplementaryViewKind {
				guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: HeaderView.reuseIdentifier,
					for: indexPath
				) as? HeaderView else {
					return nil
				}

				sectionHeader.configure(viewModel: self.presenter.userProfileInfo())
				return sectionHeader
			} else {
				guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: SectionHeaderView.reuseIdentifier,
					for: indexPath
				) as? SectionHeaderView else {
					return nil
				}

				guard let firstRepo = self.dataSource?.itemIdentifier(for: indexPath),
					  let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstRepo) else { return nil }

				sectionHeader.configure(viewModel: section.headerViewModel)
				return sectionHeader
			}
		}
	}

	func configure<T: ViewCellConfigurable>(
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

extension ProfileViewController: ProfileViewDisplayale {
	func displayView(with sections: [Section]) {
		createDatasource()
		reloadData(with: sections)
	}

	func reloadData(with datasource: [Section]) {
		refreshControl.endRefreshing()

		var snapshot = NSDiffableDataSourceSnapshot<Section, Repository>()
		snapshot.appendSections(datasource)

		for section in datasource {
			snapshot.appendItems(section.items, toSection: section)
		}
		dataSource?.apply(snapshot)
	}
}
