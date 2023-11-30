//
//  EmployeeProject.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import Foundation
import SwiftCSV

struct EmployeeProject: Decodable {
    enum Error: Swift.Error {
        case fileNotFound(name: String)
        case fileDecodingFailed(name: String, Swift.Error)
    }
    var projectID: String
    var employeeID: String
    var duration: DateInterval
    static func parseCSV(url: URL, encoding: String.Encoding = .utf8) throws -> [PairProject]? {
        do {
            let csvFile: CSV = try CSV<Enumerated>(url: url, encoding: encoding)
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate]
            var employeeProject: [EmployeeProject] = []
            var projects: [String: [EmployeeProject]] = [:]
            for row in csvFile.rows {
                guard let empID = row[safe: 0],
                      let projectID = row[safe: 1],
                      let datefromString = row[safe: 2],
                      let dateFrom = formatter.date(from:datefromString),
                      let dateToString = row[safe: 3] else {
                    continue
                }
                // If date is NULL I change it to today
                let dateTo = formatter.date(from:dateToString) ?? Date()
                if dateFrom > dateTo {
                    // we skip incorect data
                    continue
                }
                let project = EmployeeProject(projectID: projectID, employeeID: empID, duration: DateInterval(start: dateFrom, end: dateTo))
                employeeProject.append(project)
                if var proj = projects[project.projectID] {
                    proj.append(project)
                    projects[project.projectID] = proj
                } else {
                    projects[project.projectID] = [project]
                }
            }
            var personProjects: [String: [PairProject]] = [:]
            for workProj in projects.values {
                for i in 0...workProj.count-1 {
                    for j in i...workProj.count-1 {
                        if workProj[i].employeeID != workProj[j].employeeID, workProj[i].duration.intersects(workProj[j].duration), let intersaction = workProj[i].duration.intersection(with: workProj[j].duration) {
                            let personsID = workProj[i].employeeID < workProj[j].employeeID ? workProj[i].employeeID + workProj[j].employeeID : workProj[j].employeeID + workProj[i].employeeID
                            let pairProject = PairProject(employee1ID: min(workProj[i].employeeID, workProj[j].employeeID), employee2ID: max(workProj[i].employeeID, workProj[j].employeeID), projectID: workProj[i].projectID, timeWorked: intersaction.duration)
                            if var proj = personProjects[personsID] {
                                proj.append(pairProject)
                                personProjects[personsID] = proj
                            } else {
                                personProjects[personsID] = [pairProject]
                            }
                        }
                    }
                }
            }
            return personProjects.values.max {
                $0.reduce(0, {$0 + $1.daysWorked}) < $1.reduce(0, {$0 + $1.daysWorked})
            }
        } catch let parseError as CSVParseError {
            debugPrint(parseError)
            throw Error.fileDecodingFailed(name: url.absoluteString, parseError)
        } catch {
            throw Error.fileNotFound(name: url.absoluteString)
        }
    }
}
