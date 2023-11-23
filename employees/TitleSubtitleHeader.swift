//
//  TitleSubtitleHeader.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import UIKit

final class TitleSubtitleHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "TitleSubtitleHeader"
    private lazy var titleLabel = UILabel()
        .with(\.textAlignment, .center)
        .with(\.numberOfLines, .zero)
        .with(\.font, .preferredFont(forTextStyle: .title1))

    private lazy var subtitleLabel = UILabel()
        .with(\.textAlignment, .center)
        .with(\.numberOfLines, .zero)
        .with(\.font, .preferredFont(forTextStyle: .title2))

    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        .with(\.axis, .vertical)
        .with(\.isLayoutMarginsRelativeArrangement, true)
        .with(\.directionalLayoutMargins, .init(top: 16, leading: 24, bottom: 32, trailing: 24))
        .with(\.spacing, 4)

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented, please use init(reuseIdentifier: String?)")
    }

    func configure(with model: TitleSubtitleHeaderModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }

    private func setup() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        contentView.addSubview(stackView, with: [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
}
