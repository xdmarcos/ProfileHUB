// 
// HeaderView.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit
import CommonUI
import ImageCache

class HeaderView: UICollectionReusableView {
	static let supplementaryViewKind = "HeaderViewKind"
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
		static let imageSize: CGFloat = 88
		static let headerFontSize: CGFloat = 32
		static let titleFontSize: CGFloat = 16
		static let bodyFontSize: CGFloat = 16
		static let stackSpacing: CGFloat = 4
		static let numberOfLines: Int = 1
		static let textColor: UIColor = .label
		static let backgroundColor: UIColor = .systemBackground
		static let placeholderImage = "octocat"
	}

	public enum Accessibility {
		enum Identifier {
			static let rootView = "HeaderViewRootContainer"
			static let wrapper = "HeaderViewWrapperContainer"
			static let userImage = "HeaderViewUserImage"
			static let nameLabel = "HeaderViewNameLabel"
			static let usernameLabel = "HeaderViewUsernameLabel"
			static let emailLabel = "HeaderViewEmailLabel"
			static let followingLabel = "HeaderViewFollowingLabel"
			static let followersLabel = "HeaderViewFollowersLabel"
			static let followingValueLabel = "HeaderViewFollowingValueLabel"
			static let followersValueLabel = "HeaderViewFollowersValueLabel"
		}
	}

	private var imageCacheItem: ImageCacheItem?
	
	private var wrapper: UIView = {
		let wrapper = UIView()
		wrapper.backgroundColor = ViewTraits.backgroundColor
		wrapper.accessibilityIdentifier = Accessibility.Identifier.wrapper

		return wrapper
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

	private var nameLabel: UILabel = {
		let nameLabel = UILabel()
		nameLabel.textColor = ViewTraits.textColor
		nameLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: ViewTraits.headerFontSize))
		nameLabel.textAlignment = .left
		nameLabel.numberOfLines = ViewTraits.numberOfLines
		nameLabel.accessibilityIdentifier = Accessibility.Identifier.nameLabel
		return nameLabel
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

	private var emailLabel: UILabel = {
		let emailLabel = UILabel()
		emailLabel.textColor = ViewTraits.textColor
		emailLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: ViewTraits.bodyFontSize))
		emailLabel.textAlignment = .left
		emailLabel.numberOfLines = ViewTraits.numberOfLines
		emailLabel.accessibilityIdentifier = Accessibility.Identifier.emailLabel
		return emailLabel
	}()

	private var followingLabel: UILabel = {
		let followingLabel = UILabel()
		followingLabel.text = "profile_header_following_title".localized
		followingLabel.textColor = ViewTraits.textColor
		followingLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: ViewTraits.bodyFontSize))
		followingLabel.textAlignment = .left
		followingLabel.numberOfLines = ViewTraits.numberOfLines
		followingLabel.accessibilityIdentifier = Accessibility.Identifier.followingLabel
		return followingLabel
	}()

	private var followersLabel: UILabel = {
		let followersLabel = UILabel()
		followersLabel.text = "profile_header_followers_title".localized
		followersLabel.textColor = ViewTraits.textColor
		followersLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: ViewTraits.bodyFontSize))
		followersLabel.textAlignment = .left
		followersLabel.numberOfLines = ViewTraits.numberOfLines
		followersLabel.accessibilityIdentifier = Accessibility.Identifier.followersLabel
		return followersLabel
	}()

	private var followingValueLabel: UILabel = {
		let followingValueLabel = UILabel()
		followingValueLabel.textColor = ViewTraits.textColor
		followingValueLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: ViewTraits.bodyFontSize))
		followingValueLabel.textAlignment = .left
		followingValueLabel.numberOfLines = ViewTraits.numberOfLines
		followingValueLabel.accessibilityIdentifier = Accessibility.Identifier.followingValueLabel
		return followingValueLabel
	}()

	private var followersValueLabel: UILabel = {
		let followersValueLabel = UILabel()
		followersValueLabel.textColor = ViewTraits.textColor
		followersValueLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: ViewTraits.bodyFontSize))
		followersValueLabel.textAlignment = .left
		followersValueLabel.numberOfLines = ViewTraits.numberOfLines
		followersValueLabel.accessibilityIdentifier = Accessibility.Identifier.followersValueLabel
		return followersValueLabel
	}()

	private var userInfoStackView: UIStackView = {
		let userInfoStackView = UIStackView()
		userInfoStackView.axis = .vertical
		userInfoStackView.alignment = .leading
		return userInfoStackView
	}()

	private var followingStackView: UIStackView = {
		let followingStackView = UIStackView()
		followingStackView.axis = .horizontal
		followingStackView.alignment = .center
		followingStackView.spacing = ViewTraits.stackSpacing
		return followingStackView
	}()

	private var followersStackView: UIStackView = {
		let followersStackView = UIStackView()
		followersStackView.axis = .horizontal
		followersStackView.alignment = .center
		followersStackView.spacing = ViewTraits.stackSpacing
		return followersStackView
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

extension HeaderView: ViewCellConfigurable {
	typealias ViewModel = HeaderViewModel

	func configure(viewModel: HeaderViewModel) {
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
		nameLabel.text = viewModel.name
		emailLabel.text = viewModel.email
		followersValueLabel.text = viewModel.followers
		followingValueLabel.text = viewModel.following
	}
}

private extension HeaderView {
	func setupUI() {
		accessibilityIdentifier = Accessibility.Identifier.rootView
		backgroundColor = ViewTraits.backgroundColor

		wrapper.translatesAutoresizingMaskIntoConstraints = false
		userImage.translatesAutoresizingMaskIntoConstraints = false
		userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
		emailLabel.translatesAutoresizingMaskIntoConstraints = false
		followingStackView.translatesAutoresizingMaskIntoConstraints = false
		followersStackView.translatesAutoresizingMaskIntoConstraints = false

		userInfoStackView.addArrangedSubview(nameLabel)
		userInfoStackView.addArrangedSubview(usernameLabel)
		followersStackView.addArrangedSubview(followersValueLabel)
		followersStackView.addArrangedSubview(followersLabel)
		followingStackView.addArrangedSubview(followingValueLabel)
		followingStackView.addArrangedSubview(followingLabel)
		followersValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		followingValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		addSubview(wrapper)
		wrapper.addSubview(userImage)
		wrapper.addSubview(userInfoStackView)
		wrapper.addSubview(emailLabel)
		wrapper.addSubview(followingStackView)
		wrapper.addSubview(followersStackView)

		addCustomConstraints()
	}

	func addCustomConstraints() {
		NSLayoutConstraint.activate([
			wrapper.leadingAnchor.constraint(
				equalTo: leadingAnchor,
				constant: ViewTraits.contentInset.left
			),
			wrapper.trailingAnchor.constraint(
				equalTo: trailingAnchor,
				constant: -ViewTraits.contentInset.right
			),
			wrapper.topAnchor.constraint(
				equalTo: topAnchor,
				constant: ViewTraits.contentInset.top
			),
			wrapper.bottomAnchor.constraint(
				equalTo: bottomAnchor,
				constant: -ViewTraits.contentInset.bottom
			),

			userImage.leadingAnchor.constraint(
				equalTo: wrapper.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			userImage.topAnchor.constraint(
				equalTo: wrapper.topAnchor,
				constant: ViewTraits.Margin.two.points
			),
			userImage.heightAnchor.constraint(
				equalToConstant: ViewTraits.imageSize
			),
			userImage.widthAnchor.constraint(
				equalToConstant: ViewTraits.imageSize
			),

			userInfoStackView.leadingAnchor.constraint(
				equalTo: userImage.trailingAnchor,
				constant: ViewTraits.Margin.one.points
			),
			userInfoStackView.trailingAnchor.constraint(
				equalTo: wrapper.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),
			userInfoStackView.centerYAnchor.constraint(
				equalTo: userImage.centerYAnchor
			),

			emailLabel.leadingAnchor.constraint(
				equalTo: wrapper.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			emailLabel.trailingAnchor.constraint(
				equalTo: wrapper.trailingAnchor,
				constant: -ViewTraits.Margin.two.points
			),
			emailLabel.topAnchor.constraint(
				equalTo: userImage.bottomAnchor,
				constant: ViewTraits.Margin.three.points
			),

			followingStackView.leadingAnchor.constraint(
				equalTo: wrapper.leadingAnchor,
				constant: ViewTraits.Margin.two.points
			),
			followingStackView.topAnchor.constraint(
				equalTo: emailLabel.bottomAnchor,
				constant: ViewTraits.Margin.two.points
			),
			followingStackView.bottomAnchor.constraint(
				equalTo: wrapper.bottomAnchor,
				constant: -ViewTraits.Margin.three.points
			),

			followersStackView.leadingAnchor.constraint(
				equalTo: followingStackView.trailingAnchor,
				constant: ViewTraits.Margin.two.points
			),

			followersStackView.topAnchor.constraint(
				equalTo: followingStackView.topAnchor
			),
			followersStackView.bottomAnchor.constraint(
				equalTo: followingStackView.bottomAnchor
			)
		])
	}
}
