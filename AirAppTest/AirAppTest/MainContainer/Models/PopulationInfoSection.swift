//
//  PopulationInfoSection.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

struct PopulationInfoSection: Hashable {
    let info: StatePopulationInfo
    let cellsInfo: [StatePopulationInfo]?
}

extension PopulationInfoSection {
    func hash(into hasher: inout Hasher) {
        hasher.combine(info)
        hasher.combine(cellsInfo)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.info == rhs.info
        && lhs.cellsInfo == rhs.cellsInfo
    }
}
