//
//  DataTypes.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 26/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import Foundation


struct Player {
    let name: String
    var skippedAcquisitionPhase: Bool
    var skippedCombatPhase: Bool
    
    init(_ name: String) {
        self.name = name
        self.skippedAcquisitionPhase = false
        self.skippedCombatPhase = false
    }
}

struct Phase {
    let id: Int
    let name: String
}

struct Action {
    let id: Int
    let phaseID: Int
    let name: String
    let details: String
}

struct RuleSet {
    let playerCount: Int
    let rules: String
}

struct TurnState {
    var player: Int
    var isFirstTurn: Bool = false
    var currentPhase: Int = 0
    var currentAction: Int = 0
}

enum CellState {
    case COMPLETED_ACTION
    case CURRENT_ACTION
    case UPCOMING_ACTION
}
