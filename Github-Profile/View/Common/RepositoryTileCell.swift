// 
// RepositoryTileCell.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

class RepositoryTileCell: UICollectionViewCell {
	private enum ViewTraits {
		static let contentInset = UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 0,
			right: 0
		)
		enum Margin: CGFloat {
			case one = 8
			case two = 16
			case three = 24
			case four = 32

			var points: CGFloat {
				self.rawValue
			}
		}
		static let tileCornerRadius: CGFloat = 8
		static let tileBorderWidht: CGFloat = 1
		static let imageSize: CGFloat = 40
		static let titleFontSize: CGFloat = 14
		static let bodyFontSize: CGFloat = 16
		static let numberOfLines: Int = 1
		static let stackSpacing: CGFloat = 4
		static let smallImageSize: CGFloat = 12
		static let textColor: UIColor = .label
		static let backgroundColor: UIColor = .systemBackground
		static let placeholderImage = "octocat"
	}

	public enum Accessibility {
		enum Identifier {
			static let rootView = "RepositoryTileRootContainer"
			static let tile = "RepositoryTileTileContainer"
			static let userImage = "RepositoryTileUserImage"
			static let usernameLabel = "RepositoryTileUsernameLabel"
			static let repoTitleLabel = "RepositoryTileRepoTitleLabel"
			static let repoDescriptionLabel = "RepositoryTileRepoDescriptionLabel"
			static let starsLabel = "RepositoryTileStarsLabel"
			static let languageLabel = "RepositoryTileLanguageLabel"
			static let starsImage = "RepositoryTileStarsImage"
			static let languageImage = "RepositoryTileLanguageImage"
			static let starsStackView = "RepositoryTileStarsStackView"
			static let languageStackView  = "RepositoryTileLanguageStackView "
		}
	}

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

	private var starsImage: UIImageView = {
		let starsImage = UIImageView()
		starsImage.image = UIImage(systemName: "star.fill")
		starsImage.tintColor = .systemYellow // TODO: use Proper color
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
		userImage.image = UIImage(named: ViewTraits.placeholderImage)
	}
}

extension RepositoryTileCell: ViewCellConfigurable {
	typealias ViewModel = Repository

	func configure(viewModel: Repository) {
//		userImage.image = viewModel.userImage // TODO: load image
		usernameLabel.text = viewModel.username
		repoTitleLabel.text = viewModel.repoName
		repoDescriptionLabel.text = viewModel.repoDescription
		starsLabel.text = viewModel.stars
		languageLabel.text = viewModel.language
		languageImage.tintColor = .systemRed // TODO: use viewModel.languageColor
	}
}

private extension RepositoryTileCell {
	func setupUI() {
		accessibilityIdentifier = Accessibility.Identifier.rootView
		backgroundColor = ViewTraits.backgroundColor

		tile.translatesAutoresizingMaskIntoConstraints = false
		userImage.translatesAutoresizingMaskIntoConstraints = false
		usernameLabel.translatesAutoresizingMaskIntoConstraints = false
		repoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		repoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		starsImage.translatesAutoresizingMaskIntoConstraints = false
		languageImage.translatesAutoresizingMaskIntoConstraints = false
		starsStackView.translatesAutoresizingMaskIntoConstraints = false
		languageStackView.translatesAutoresizingMaskIntoConstraints = false
		starsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		starsStackView.addArrangedSubview(starsImage)
		starsStackView.addArrangedSubview(starsLabel)
		languageStackView.addArrangedSubview(languageImage)
		languageStackView.addArrangedSubview(languageLabel)

		contentView.addSubview(tile)
		tile.addSubview(userImage)
		tile.addSubview(usernameLabel)
		tile.addSubview(repoTitleLabel)
		tile.addSubview(repoDescriptionLabel)
		tile.addSubview(starsStackView)
		tile.addSubview(languageStackView)

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

			userImage.leadingAnchor.constraint(
				equalTo: tile.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			userImage.topAnchor.constraint(
				equalTo: tile.topAnchor,
				constant: ViewTraits.Margin.two.points
			),
			userImage.heightAnchor.constraint(
				equalToConstant: ViewTraits.imageSize
			),
			userImage.widthAnchor.constraint(
				equalToConstant: ViewTraits.imageSize
			),

			usernameLabel.leadingAnchor.constraint(
				equalTo: userImage.trailingAnchor,
				constant: ViewTraits.Margin.one.points
			),
			usernameLabel.trailingAnchor.constraint(
				equalTo: tile.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),
			usernameLabel.centerYAnchor.constraint(
				equalTo: userImage.centerYAnchor
			),

			repoTitleLabel.leadingAnchor.constraint(
				equalTo: tile.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			repoTitleLabel.trailingAnchor.constraint(
				equalTo: tile.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),
			repoTitleLabel.topAnchor.constraint(
				equalTo: userImage.bottomAnchor,
				constant: ViewTraits.Margin.two.points
			),

			repoDescriptionLabel.leadingAnchor.constraint(
				equalTo: tile.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			repoDescriptionLabel.trailingAnchor.constraint(
				equalTo: tile.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),
			repoDescriptionLabel.topAnchor.constraint(
				equalTo: repoTitleLabel.bottomAnchor,
				constant: ViewTraits.Margin.one.points
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
				equalTo: repoDescriptionLabel.bottomAnchor,
				constant: ViewTraits.Margin.three.points
			),
			starsStackView.bottomAnchor.constraint(
				equalTo: tile.bottomAnchor,
				constant: -ViewTraits.Margin.four.points
			),

			languageStackView.leadingAnchor.constraint(
				equalTo: starsStackView.trailingAnchor,
				constant: ViewTraits.Margin.four.points
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
