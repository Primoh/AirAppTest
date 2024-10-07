//
//  MainFlowOutput.swift
//  AirAppTest
//
//  Created by Daniel Primo on 06/10/2024.
//

struct MainFlowOutput {
    typealias OnEventClosure = (_ event: MainFlowOutput.Events) -> Void

    enum Events {
        case dialogError(String, String)
    }
    
    let onEventClosure: OnEventClosure
}
