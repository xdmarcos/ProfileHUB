// 
// SectionHeaderView.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
	private enum ViewTraits {
		static let contentInset = UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 20,
			right: 0
		)

		static let titleFontSize: CGFloat = 22
		static let actionFontSize: CGFloat = 18
		static let numberOfLines: Int = 1
		static let textColor: UIColor = .label
		static let backgroundColor: UIColor = .systemBackground
		static let underlineAttributes:[NSAttributedString.Key: Any] = [
			NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
			NSAttributedString.Key.foregroundColor: UIColor.label,
			NSAttributedString.Key.font: UIFontMetrics.default.scaledFont(
				for: UIFont.systemFont(
					ofSize: ViewTraits.actionFontSize,
					weight: .bold
				)
			)
		]
	}

	public enum Accessibility {
		enum Identifier {
			static let rootView = "SectionHeaderRootContainer"
			static let stackView = "SectionHeaderStakView"
			static let tile = "SectionHeaderTitleLabel"
			static let actionButton = "SectionHeaderActionButton"
		}
	}
	
	private var title: UILabel = {
		let title = UILabel()
		title.textColor = ViewTraits.textColor
		title.numberOfLines = ViewTraits.numberOfLines
		title.font = UIFontMetrics.default.scaledFont(
			for: UIFont.systemFont(
				ofSize: ViewTraits.titleFontSize,
				weight: .bold)
		)
		title.accessibilityIdentifier = Accessibility.Identifier.tile
		return title
	}()

	private var actionButton: UIButton = {
		let actionButton = UIButton(type: .custom)
		actionButton.accessibilityIdentifier = Accessibility.Identifier.actionButton
		return actionButton
	}()

	private var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.accessibilityIdentifier = Accessibility.Identifier.stackView
		return stackView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SectionHeaderView: ViewCellConfigurable {
	typealias ViewModel = SectionHeaderViewModel

	func configure(viewModel: SectionHeaderViewModel) {
		title.text = viewModel.title

		let attributedTitle = NSAttributedString(
			string: viewModel.actionTitle,
			attributes: ViewTraits.underlineAttributes
		)
		actionButton.setAttributedTitle(attributedTitle, for: .normal)
	}
}

private extension SectionHeaderView {
	func setupUI () {
		backgroundColor = ViewTraits.backgroundColor
		accessibilityIdentifier = Accessibility.Identifier.rootView

		actionButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		stackView.translatesAutoresizingMaskIntoConstraints = false

		stackView.addArrangedSubview(title)
		stackView.addArrangedSubview(actionButton)

		addSubview(stackView)

		addCustomConstraints()
	}

	func addCustomConstraints() {
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.contentInset.left),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ViewTraits.contentInset.right),
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.contentInset.top),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.contentInset.bottom)
		])
	}
}
