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
        init(_ project: PairProject) {
            employee1ID = project.employee1ID
            employee2ID = project.employee2ID
            projectID = project.projectID
            timeWorked = String(project.daysWorked)
        }
    }
}

protocol TitleSubtitleHeaderModel {
    var title: String { get }
    var subtitle: String? { get }
}

protocol EmployeePairPresenterProtocol {
    var tableViewSections: [EmployeePairSectionModel] { get }

    func load(url: URL?)
    func selectFile()
}

final class EmployeePairPresenter: NSObject, EmployeePairPresenterProtocol {
    weak var view: EmployeePairViewViewDelegate?

    var tableViewSections: [EmployeePairSectionModel] = []

    init(viewModel: [EmployeePairSectionModel]) {
        self.tableViewSections = viewModel
    }

    func load(url: URL?) {
        guard let url = url, url.startAccessingSecurityScopedResource() else {
            view?.showGetClientError(error: EmployeeProject.Error.fileNotFound(name: url?.absoluteString ?? ""))
            return
        }
        // Make sure you release the security-scoped resource when you finish.
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            let employees = try EmployeeProject.parseCSV(url: url)
            guard let employees else {
                return
            }
            tableViewSections = [EmployeePairSectionModel(header:
                                                            EmployeePairSectionModel.Header(title: "Total time worked together", subtitle: "\(String(employees.reduce(0, {$0 + $1.daysWorked}))) days"),
                                                          items: employees.map { EmployeePairSectionModel.EmployeePairItem.init($0) })]
            view?.setupContent()
        } catch let error {
            view?.showGetClientError(error: error)
        }
    }

    func selectFile() {
        let documentsPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.commaSeparatedText])
        documentsPicker.delegate = self
        documentsPicker.allowsMultipleSelection = false
        documentsPicker.modalPresentationStyle = .fullScreen
        view?.present(documentsPicker)
    }
}

//MARK: - Ext. Delegate DocumentPicker
extension EmployeePairPresenter: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            view?.showGetClientError(error: EmployeeProject.Error.fileNotFound(name: ""))
            return
        }
        
        self.load(url: url)
    }

    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    }
}
