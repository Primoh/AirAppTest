//
//  DispatchQueueType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 06/10/2024.
//

import Foundation

protocol DispatchMainQueueType {
    func asyncThread(
        execute work: @escaping @convention(block) () -> Void
    )
}

extension DispatchQueue: DispatchMainQueueType {
    func asyncThread(
        execute work: @escaping @convention(block) () -> Void
    ) {
        async(
            group: nil,
            qos: .unspecified,
            flags: [],
            execute: work
        )
    }
}
