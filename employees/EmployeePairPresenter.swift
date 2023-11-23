//
//  EmployeePairPresenter.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import UIKit

struct EmployeePairSectionModel {
    let header: Header?
    let items: [EmployeePairItem]

    struct Header: TitleSubtitleHeaderModel {
        let title: String
        let subtitle: String?
    }

    struct EmployeePairItem: EmployeePairCellModelProtocol {
        var employee1ID: String
        var employee2ID: String
        var projectID: String
        var timeWorked: String
    }
}

protocol TitleSubtitleHeaderModel {
    var title: String { get }
    var subtitle: String? { get }
}

protocol EmployeePairPresenterProtocol {
    var tableViewSections: [EmployeePairSectionModel] { get }

    func load()
    func selectFile()
}

final class EmployeePairPresenter: EmployeePairPresenterProtocol {
    weak var view: EmployeePairViewViewDelegate?

    var tableViewSections: [EmployeePairSectionModel] = []

    init(viewModel: [EmployeePairSectionModel]) {
        self.tableViewSections = viewModel
    }

    func load() {
        view?.setupContent()
    }

    func selectFile() {
    }
}
