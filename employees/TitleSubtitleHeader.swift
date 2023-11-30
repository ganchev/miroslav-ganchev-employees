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
    

    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, labelsStackView])
        .with(\.axis, .vertical)
        .with(\.isLayoutMarginsRelativeArrangement, true)
        .with(\.directionalLayoutMargins, .init(top: 16, leading: 16, bottom: 24, trailing: 16))
        .with(\.spacing, 8)
    
    private lazy var employee1Label = UILabel()
        .with(\.numberOfLines, .zero)
        .with(\.text, NSLocalizedString("Employee 1", comment: ""))
        .with(\.font, .preferredFont(forTextStyle: .body))

    private lazy var employee2Label = UILabel()
        .with(\.font, .preferredFont(forTextStyle: .body))
        .with(\.numberOfLines, .zero)
        .with(\.text, NSLocalizedString("Employee 2", comment: ""))
    
    private lazy var projectLabel = UILabel()
        .with(\.numberOfLines, .zero)
        .with(\.font, .preferredFont(forTextStyle: .body))
        .with(\.text, NSLocalizedString("Project ID", comment: ""))

    private lazy var timeWorkedLabel = UILabel()
        .with(\.font, .preferredFont(forTextStyle: .body))
        .with(\.text, NSLocalizedString("Time worked", comment: ""))
        .with(\.numberOfLines, .zero)

    private lazy var labelsStackView = UIStackView(arrangedSubviews: [employee1Label, employee2Label, projectLabel, timeWorkedLabel])
        .with(\.axis, .horizontal)
        .with(\.spacing, 4)
        .with(\.distribution, .fillEqually)

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
        contentView.addSubview(stackView, with: [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
