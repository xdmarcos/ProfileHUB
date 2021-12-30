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
	private(set) var presenter: ProfilePresentable
	private(set) var profileDatasource: UICollectionViewDiffableDataSource<Section, Repository>?
	private(set) var sceneView = ProfileView()
	private var refreshControl = UIRefreshControl()

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
		title = "profile_summary_title".localized

		refreshControl.attributedTitle = NSAttributedString(string: "profile_refresh_title".localized)
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

extension ProfileViewController: ProfileViewDisplayale {
	func displayView(with sections: [Section]) {
		profileDatasource = createDatasource()
		reloadData(with: sections)
	}

	func reloadData(with datasource: [Section]) {
		refreshControl.endRefreshing()

		var snapshot = NSDiffableDataSourceSnapshot<Section, Repository>()
		snapshot.appendSections(datasource)

		for section in datasource {
			snapshot.appendItems(section.items, toSection: section)
		}
		profileDatasource?.apply(snapshot)
	}
}
