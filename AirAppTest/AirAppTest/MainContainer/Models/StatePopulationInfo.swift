//
//  StateInfo.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

struct StatePopulationInfo: Hashable {
    let name: String
    let population: String
}

extension StatePopulationInfo {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(population)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
        && lhs.population == rhs.population
    }
}
