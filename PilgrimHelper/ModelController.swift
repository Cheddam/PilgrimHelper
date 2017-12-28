//
//  ModelController.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 27/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import Foundation

class ModelController {
    
    // MARK: Static Data
    public let MaxPlayerCount = 4
    public let PhaseList = [Phase(id: 1, name: "Acquisition"), Phase(id: 2, name: "Combat"), Phase(id: 3, name: "Resolution")]
    public let ActionList = [Action(id: 1, phaseID: 1, name: "Generate Resources"), Action(id: 2, phaseID: 2, name: "Acquire Card(s)")]
    public let RuleSets = [
        RuleSet(playerCount: 1, rules: "Exclude Wallace and Kim from the pool of available characters."),
        RuleSet(playerCount: 2, rules: "Exclude Wallace and Kim from the pool of available characters."),
        RuleSet(playerCount: 3, rules: "Include Wallace and Kim in the pool of available characters."),
        RuleSet(playerCount: 4, rules: "Include Wallace and Kim in the pool of available characters."),
    ]
    
    
    // MARK: User Input
    public var players = [String]()
    
    // MARK: Game State
    var startingPlayerIndex = 0
    public var currentTurnPlayerIndex = 0
    
    // MARK: Getter Methods
    public func startingPlayerName() -> String {
        return players[startingPlayerIndex]
    }
    
    public func currentRuleset() -> String {
        let matchingRulesets = RuleSets.filter { $0.playerCount == players.count }
        
        return matchingRulesets.first!.rules
    }
    
    // MARK: Setter Methods
    public func generateStartingPlayer() {
        startingPlayerIndex = Int(arc4random_uniform(UInt32(players.count)))
    }
    
}
