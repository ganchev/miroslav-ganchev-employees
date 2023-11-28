//
//  EmployeePairViewController.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import UIKit

protocol EmployeePairViewViewDelegate: AnyObject {
    func setupContent()
    func present(_ viewController: UIViewController)
}

final class EmployeePairViewController: UIViewController {
    private let presenter: EmployeePairPresenterProtocol

    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
        .with(\.backgroundColor, .systemGroupedBackground)
        .with(\.delegate, self)
        .with(\.dataSource, self)
        .with(\.rowHeight, UITableView.automaticDimension)
        .with(\.estimatedRowHeight, UITableView.automaticDimension)
        .with(\.estimatedSectionHeaderHeight, 100)
        .with(\.sectionHeaderHeight, UITableView.automaticDimension)
        .with {
            $0.register(TitleSubtitleHeader.self, forHeaderFooterViewReuseIdentifier: TitleSubtitleHeader.reuseIdentifier)
            $0.register(EmployeePairCell.self, forCellReuseIdentifier: EmployeePairCell.reuseIdentifier)
        }

    init(presenter: EmployeePairPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter.load(url: nil)
    }

    private func setupLayout() {
        view.addSubview(tableView, with: [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        self.title = "Pair of employees"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = nil
        navBarAppearance.backgroundColor = .systemGroupedBackground
        navigationItem.standardAppearance = navBarAppearance
        navigationItem.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(selectFileTapped))

    }

    @objc private func selectFileTapped() {
        presenter.selectFile()
    }
}

extension EmployeePairViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.tableViewSections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = presenter.tableViewSections[safe: indexPath.section], let item = section.items[safe: indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: EmployeePairCell.reuseIdentifier, for: indexPath) as? EmployeePairCell else {
            assertionFailure("Failed to get cell for row at: \(indexPath)")
            return UITableViewCell()
        }
        cell.configure(with: item)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let section = presenter.tableViewSections[safe: section],
           let headerModel = section.header,
           let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleSubtitleHeader.reuseIdentifier) as? TitleSubtitleHeader {
            headerView.configure(with: headerModel)
            return headerView
        }

        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let section = presenter.tableViewSections[safe: section], section.header != nil {
            return UITableView.automaticDimension
        }
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = presenter.tableViewSections[section]
        return section.items.count
    }
}

extension EmployeePairViewController: EmployeePairViewViewDelegate {
    func setupContent() {
        tableView.reloadData()
    }
    
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func showGetClientError(error: Error, shouldDismiss: Bool) {
        let alertController = UIAlertController(title: "Error during API communication",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        self.present(alertController, animated: true)
    }
}
