// 
// RepositoryTileCell.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit
import CommonUI
import ImageCache

class RepositoryTileCell: UICollectionViewCell {
	private enum ViewTraits {
		static let contentInset = UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 0,
			right: 0
		)
		enum Margin: CGFloat {
			case half = 3
			case one = 7
			case two = 16
			case three = 28

			var points: CGFloat {
				self.rawValue
			}
		}
		static let tileCornerRadius: CGFloat = 8
		static let tileBorderWidht: CGFloat = 1
		static let imageSize: CGFloat = 32
		static let titleFontSize: CGFloat = 16
		static let bodyFontSize: CGFloat = 16
		static let numberOfLines: Int = 1
		static let stackSpacing: CGFloat = 4
		static let smallImageSize: CGFloat = 12
		static let textColor: UIColor = .label
		static let backgroundColor: UIColor = .systemBackground
		static let placeholderImage = "octocat"
		static let yellowStarColor = "#FFED00"
	}

	public enum Accessibility {
		enum Identifier {
			static let rootView = "RepositoryTileRootContainer"
			static let tile = "RepositoryTileTileContainer"
			static let userImage = "RepositoryTileUserImage"
			static let usernameLabel = "RepositoryTileUsernameLabel"
			static let userStackView = "RepositoryTileUserStackView"
			static let repoTitleLabel = "RepositoryTileRepoTitleLabel"
			static let repoDescriptionLabel = "RepositoryTileRepoDescriptionLabel"
			static let starsLabel = "RepositoryTileStarsLabel"
			static let languageLabel = "RepositoryTileLanguageLabel"
			static let repoInfoStackView = "RepositoryTileRepoInfoStackView"
			static let starsImage = "RepositoryTileStarsImage"
			static let languageImage = "RepositoryTileLanguageImage"
			static let starsStackView = "RepositoryTileStarsStackView"
			static let languageStackView  = "RepositoryTileLanguageStackView "
		}
	}

	private var imageCacheItem: ImageCacheItem?

	private var tile: UIView = {
		let tile = UIView()
		tile.backgroundColor = ViewTraits.backgroundColor
		tile.clipsToBounds = true
		tile.layer.cornerRadius = ViewTraits.tileCornerRadius
		tile.layer.borderWidth = ViewTraits.tileBorderWidht
		tile.layer.borderColor = UIColor.systemGray.cgColor
		tile.accessibilityIdentifier = Accessibility.Identifier.tile

		return tile
	}()

	private var userImage: UIImageView = {
		let userImage = UIImageView()
		userImage.image = UIImage(named: ViewTraits.placeholderImage)
		userImage.backgroundColor = .tertiarySystemBackground
		userImage.contentMode = .scaleAspectFit
		userImage.clipsToBounds = true
		userImage.layer.cornerRadius = ViewTraits.imageSize / 2
		userImage.accessibilityIdentifier = Accessibility.Identifier.userImage
		return userImage
	}()

	private var usernameLabel: UILabel = {
		let usernameLabel = UILabel()
		usernameLabel.textColor = ViewTraits.textColor
		usernameLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: ViewTraits.titleFontSize))
		usernameLabel.textAlignment = .left
		usernameLabel.numberOfLines = ViewTraits.numberOfLines
		usernameLabel.accessibilityIdentifier = Accessibility.Identifier.usernameLabel
		return usernameLabel
	}()

	private var userStackView: UIStackView = {
		let userStackView = UIStackView()
		userStackView.axis = .horizontal
		userStackView.distribution = .fill
		userStackView.alignment = .center
		userStackView.spacing = ViewTraits.stackSpacing
		userStackView.accessibilityIdentifier = Accessibility.Identifier.userStackView
		return userStackView
	}()

	private var repoTitleLabel: UILabel = {
		let repoTitleLabel = UILabel()
		repoTitleLabel.textColor = ViewTraits.textColor
		repoTitleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: ViewTraits.bodyFontSize))
		repoTitleLabel.textAlignment = .left
		repoTitleLabel.numberOfLines = ViewTraits.numberOfLines
		repoTitleLabel.accessibilityIdentifier = Accessibility.Identifier.repoTitleLabel
		return repoTitleLabel
	}()

	private var repoDescriptionLabel: UILabel = {
		let repoDescriptionLabel = UILabel()
		repoDescriptionLabel.textColor = ViewTraits.textColor
		repoDescriptionLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: ViewTraits.bodyFontSize))
		repoDescriptionLabel.textAlignment = .left
		repoDescriptionLabel.numberOfLines = ViewTraits.numberOfLines
		repoDescriptionLabel.accessibilityIdentifier = Accessibility.Identifier.repoDescriptionLabel
		return repoDescriptionLabel
	}()

	private var starsLabel: UILabel = {
		let starsLabel = UILabel()
		starsLabel.textColor = ViewTraits.textColor
		starsLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: ViewTraits.bodyFontSize))
		starsLabel.textAlignment = .left
		starsLabel.numberOfLines = ViewTraits.numberOfLines
		starsLabel.accessibilityIdentifier = Accessibility.Identifier.starsLabel
		return starsLabel
	}()

	private var languageLabel: UILabel = {
		let languageLabel = UILabel()
		languageLabel.textColor = ViewTraits.textColor
		languageLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: ViewTraits.bodyFontSize))
		languageLabel.textAlignment = .left
		languageLabel.numberOfLines = ViewTraits.numberOfLines
		languageLabel.accessibilityIdentifier = Accessibility.Identifier.languageLabel
		return languageLabel
	}()

	private var repoInfoStackView: UIStackView = {
		let repoInfoStackView = UIStackView()
		repoInfoStackView.axis = .vertical
		repoInfoStackView.alignment = .leading
		repoInfoStackView.spacing = ViewTraits.stackSpacing
		repoInfoStackView.accessibilityIdentifier = Accessibility.Identifier.repoInfoStackView
		return repoInfoStackView
	}()

	private var starsImage: UIImageView = {
		let starsImage = UIImageView()
		starsImage.image = UIImage(systemName: "star.fill")
		starsImage.tintColor = UIColor(ViewTraits.yellowStarColor)
		starsImage.contentMode = .scaleAspectFill
		starsImage.accessibilityIdentifier = Accessibility.Identifier.starsImage
		return starsImage
	}()

	private var languageImage: UIImageView = {
		let languageImage = UIImageView()
		languageImage.image = UIImage(systemName: "circle.fill")
		languageImage.contentMode = .scaleAspectFill
		languageImage.accessibilityIdentifier = Accessibility.Identifier.languageImage
		return languageImage
	}()

	private var starsStackView: UIStackView = {
		let starsStackView = UIStackView()
		starsStackView.axis = .horizontal
		starsStackView.alignment = .center
		starsStackView.spacing = ViewTraits.stackSpacing
		starsStackView.accessibilityIdentifier = Accessibility.Identifier.starsStackView
		return starsStackView
	}()

	private var languageStackView: UIStackView = {
		let languageStackView = UIStackView()
		languageStackView.axis = .horizontal
		languageStackView.alignment = .center
		languageStackView.spacing = ViewTraits.stackSpacing
		languageStackView.accessibilityIdentifier = Accessibility.Identifier.languageStackView
		return languageStackView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		guard let imageURL = imageCacheItem?.url else { return }
		userImage.cancelImageLoad(imageURL)
	}
}

extension RepositoryTileCell: ViewCellConfigurable {
	typealias ViewModel = Repository

	func configure(viewModel: Repository) {
		if let imageURL = URL(string: viewModel.userImageUrl) {
			let imageItem = ImageCacheItem(
				image: nil,
				url: imageURL,
				placeHolderImage: UIImage(named: ViewTraits.placeholderImage)
			)
			imageCacheItem = imageItem
			userImage.loadImage(for: imageItem, animated: true)
		}

		usernameLabel.text = viewModel.username
		repoTitleLabel.text = viewModel.repoName
		repoDescriptionLabel.text = viewModel.repoDescription
		starsLabel.text = viewModel.stars
		languageLabel.text = viewModel.language
		languageImage.tintColor = UIColor(viewModel.languageColor)
	}
}

private extension RepositoryTileCell {
	func setupUI() {
		accessibilityIdentifier = Accessibility.Identifier.rootView
		backgroundColor = ViewTraits.backgroundColor

		userStackView.addArrangedSubview(userImage)
		userStackView.addArrangedSubview(usernameLabel)
		repoInfoStackView.addArrangedSubview(repoTitleLabel)
		repoInfoStackView.addArrangedSubview(repoDescriptionLabel)
		starsStackView.addArrangedSubview(starsImage)
		starsStackView.addArrangedSubview(starsLabel)
		languageStackView.addArrangedSubview(languageImage)
		languageStackView.addArrangedSubview(languageLabel)
		starsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		contentView.addSubviewForAutolayout(subview: tile)
		tile.addSubviewForAutolayout(subview: userStackView)
		tile.addSubviewForAutolayout(subview: repoInfoStackView)
		tile.addSubviewForAutolayout(subview: starsStackView)
		tile.addSubviewForAutolayout(subview: languageStackView)

		addCustomConstraints()
	}

	func addCustomConstraints() {
		NSLayoutConstraint.activate([
			tile.leadingAnchor.constraint(
				equalTo: leadingAnchor,
				constant: ViewTraits.contentInset.left
			),
			tile.trailingAnchor.constraint(
				equalTo: trailingAnchor,
				constant: -ViewTraits.contentInset.right
			),
			tile.topAnchor.constraint(
				equalTo: topAnchor,
				constant: ViewTraits.contentInset.top
			),
			tile.bottomAnchor.constraint(
				equalTo: bottomAnchor,
				constant: -ViewTraits.contentInset.bottom
			),

			userImage.heightAnchor.constraint(equalToConstant: ViewTraits.imageSize),
			userImage.widthAnchor.constraint(equalToConstant: ViewTraits.imageSize),

			userStackView.leadingAnchor.constraint(
				equalTo: tile.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			userStackView.topAnchor.constraint(
				equalTo: tile.topAnchor,
				constant: ViewTraits.Margin.two.points
			),
			userStackView.trailingAnchor.constraint(
				equalTo: tile.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),

			repoInfoStackView.leadingAnchor.constraint(
				equalTo: tile.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			repoInfoStackView.trailingAnchor.constraint(
				equalTo: tile.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),
			repoInfoStackView.topAnchor.constraint(
				equalTo: userStackView.bottomAnchor,
				constant:  ViewTraits.Margin.half.points
			),

			starsImage.heightAnchor.constraint(equalToConstant: ViewTraits.smallImageSize),
			starsImage.widthAnchor.constraint(equalToConstant: ViewTraits.smallImageSize),
			languageImage.heightAnchor.constraint(equalToConstant: ViewTraits.smallImageSize),
			languageImage.widthAnchor.constraint(equalToConstant: ViewTraits.smallImageSize),

			starsStackView.leadingAnchor.constraint(
				equalTo: tile.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			starsStackView.topAnchor.constraint(
				equalTo: repoInfoStackView.bottomAnchor,
				constant: ViewTraits.Margin.two.points
			),
			starsStackView.bottomAnchor.constraint(
				equalTo: tile.bottomAnchor,
				constant: -ViewTraits.Margin.three.points
			),

			languageStackView.leadingAnchor.constraint(
				equalTo: starsStackView.trailingAnchor,
				constant: ViewTraits.Margin.three.points
			),
			languageStackView.trailingAnchor.constraint(
				equalTo: tile.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),
			languageStackView.topAnchor.constraint(
				equalTo: starsStackView.topAnchor
			),
			languageStackView.bottomAnchor.constraint(
				equalTo: starsStackView.bottomAnchor
			)
		])
	}
}
