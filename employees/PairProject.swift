//
//  PairProject.swift
//  employees
//
//  Created by Miroslav Ganchev on 28.11.23.
//

import Foundation

struct PairProject {
    var employee1ID: String
    var employee2ID: String
    var projectID: String
    var timeWorked: Double
    var daysWorked: Int {
        Int(timeWorked / (24 * 3600))
    }
}
