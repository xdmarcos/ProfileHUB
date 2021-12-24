// 
// ProfileViewController.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 

import UIKit

protocol ProfileViewDisplayale: AnyObject {
	func reloadData(with datasource: [Section])
}

final class ProfileViewController: UIViewController {
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
		createDatasource() // TODO: Add to presenter

		presenter.viewDidLoad()
	}

	// MARK: Actions

	@objc func refresh(_: AnyObject) {
		presenter.reloadData()
	}
}

// MARK: - Setup UI components
private extension ProfileViewController {
	func setupUI() {
		title = "profile_summary_title"//.localized

		refreshControl.attributedTitle = NSAttributedString(string: "profile_refresh_title")//.localized)
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
			guard let self = self else { return nil }

			let section = self.presenter.section(for: sectionIndex)

			switch section.type {
			case .pinned:
				return self.createVerticalSection(using: section)
			default:
				return self.createHorizontalSection(using: section)

			}
		}

		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.interSectionSpacing = 30
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
		layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(630)
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
		layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.7),
			heightDimension: .estimated(210)
		)

		let layoutGroup = NSCollectionLayoutGroup.horizontal(
			layoutSize: layoutGroupSize,
			subitems: [layoutItem]
		)

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.orthogonalScrollingBehavior = .groupPaging

		let layoutSectionHeader = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

		var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
		if case .starred = section.type{
			contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 0)
		}

		layoutSection.contentInsets = contentInsets

		return layoutSection
	}

	func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let layoutSectionHeaderSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(80)
		)

		let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: layoutSectionHeaderSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top
		)
		layoutSectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
		layoutSectionHeader.zIndex = 0
		return layoutSectionHeader
	}

	func createBoundaryHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .estimated(210)
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
			guard let self = self else { return nil }

			switch self.presenter.section(for: indexPath.section).type {
			default:
				return self.configure(
					RepositoryTileCell.self,
					with: repository as RepositoryTileCell.ViewModel,
					for: indexPath
				)
			}
		}

		dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			if kind == HeaderView.supplementaryViewKind {
				guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: HeaderView.reuseIdentifier,
					for: indexPath
				) as? HeaderView else {
					return nil
				}
				sectionHeader.configure(
					viewModel: .init(
						name: "Marcos Gonzalez",
						username: "xdmarcos",
						userImage: UIImage(named: "octocat")!,
						email: "xdmgzdev@gmail.com",
						following: "3",
						followers: "0"
					)
				)
				return sectionHeader
			} else {
				guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: SectionHeaderView.reuseIdentifier,
					for: indexPath
				) as? SectionHeaderView else {
					return nil
				}

				guard let firstRepo = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
				guard let section = self?.dataSource?.snapshot().sectionIdentifier(
					containingItem: firstRepo
				) else { return nil }

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
	func reloadData(with datasource: [Section]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Repository>()
		snapshot.appendSections(datasource)

		for section in datasource {
			snapshot.appendItems(section.items, toSection: section)
		}

		dataSource?.apply(snapshot)
	}
}
