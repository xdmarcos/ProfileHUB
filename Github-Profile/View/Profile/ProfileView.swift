// 
// ProfileView.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

final class ProfileView: UIView {
	private enum ViewTraits {
		static let contentInset = UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 0,
			right: 0
		)
		static let backgroundColor: UIColor = .systemBackground
	}

	public enum Accessibility {
		enum Identifier {
			static let rootView = "ProfileViewRootContainer"
			static let collectionView = "ProfileViewCollectionView"
		}
	}

	var profileCollectionView: UICollectionView = {
		let profileCollectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: UICollectionViewFlowLayout()
		)
		profileCollectionView.showsVerticalScrollIndicator = false
		profileCollectionView.showsHorizontalScrollIndicator = false
		profileCollectionView.backgroundColor = ViewTraits.backgroundColor
		profileCollectionView.accessibilityIdentifier = Accessibility.Identifier.collectionView
		return profileCollectionView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension ProfileView {
	func setupUI() {
		accessibilityIdentifier = Accessibility.Identifier.rootView
		backgroundColor = ViewTraits.backgroundColor

		addSubviewForAutolayout(subview: profileCollectionView)

		addCustomConstraints()
	}

	func addCustomConstraints() {
		NSLayoutConstraint.activate([
			profileCollectionView.leadingAnchor.constraint(
				equalTo: leadingAnchor,
				constant: ViewTraits.contentInset.left
			),
			profileCollectionView.trailingAnchor.constraint(
				equalTo: trailingAnchor,
				constant: -ViewTraits.contentInset.right
			),
			profileCollectionView.topAnchor.constraint(
				equalTo: safeAreaLayoutGuide.topAnchor,
				constant: ViewTraits.contentInset.top
			),
			profileCollectionView.bottomAnchor.constraint(
				equalTo: safeAreaLayoutGuide.bottomAnchor,
				constant: -ViewTraits.contentInset.bottom
			)
		])
	}
}
