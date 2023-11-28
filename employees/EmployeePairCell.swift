//
//  EmployeePairCell.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import UIKit

protocol EmployeePairCellModelProtocol {
    var employee1ID: String { get }
    var employee2ID: String { get }
    var projectID: String { get }
    var timeWorked: String { get }
}

final class EmployeePairCell: UITableViewCell {
    static let reuseIdentifier = "item_cell"

    private lazy var employee1Label = UILabel()
        .with(\.numberOfLines, .zero)
        .with(\.font, .preferredFont(forTextStyle: .body))

    private lazy var employee2Label = UILabel()
        .with(\.font, .preferredFont(forTextStyle: .body))
        .with(\.numberOfLines, .zero)
    
    private lazy var projectLabel = UILabel()
        .with(\.numberOfLines, .zero)
        .with(\.font, .preferredFont(forTextStyle: .body))

    private lazy var timeWorkedLabel = UILabel()
        .with(\.font, .preferredFont(forTextStyle: .body))
        .with(\.numberOfLines, .zero)

    private lazy var labelsStackView = UIStackView(arrangedSubviews: [employee1Label, employee2Label, projectLabel, timeWorkedLabel])
        .with(\.axis, .horizontal)
        .with(\.spacing, 4)
        .with(\.distribution, .fillEqually)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented, please use init(reuseIdentifier: String?)")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        employee1Label.text = nil
        employee2Label.text = nil
        projectLabel.text = nil
        timeWorkedLabel.text = nil
    }

    func configure(with model: EmployeePairCellModelProtocol) {
        employee1Label.text = model.employee1ID
        employee2Label.text = model.employee2ID
        projectLabel.text = model.projectID
        timeWorkedLabel.text = model.timeWorked
    }

    private func setup() {
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)

        contentView.addSubview(labelsStackView, with: [
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

