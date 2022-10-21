//
//  Model.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 21.10.2022.
//

import UIKit

struct Model: Decodable {
    var company: Company
}

struct Company: Decodable {
    let name: String
    var employees: [Employees]
}

struct Employees: Decodable, Comparable {
    static func < (lhs: Employees, rhs: Employees) -> Bool {
        return lhs.name < rhs.name
    }
    
    let name: String
    let phone_number: String
    let skills: [String]
}

