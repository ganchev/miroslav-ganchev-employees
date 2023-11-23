//
//  Project.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import Foundation

struct EmployeeProject: Decodable {
    var projectID: String
    var employeeID: String
    var duration: DateInterval
}

struct Project {
    var projectID: String
    var employeeProjects: [EmployeeProject]
}

struct PairProject {
    var employee1ID: String
    var employee2ID: String
    var projectID: String
    var timeWorked: Double
    var daysWorked: Int {
        Int(timeWorked / 24 * 3600 * 1000)
    }
}
