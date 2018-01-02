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
    public let PhaseList = [
        Phase(id: 1, name: "Acquisition"),
        Phase(id: 2, name: "Combat"),
        Phase(id: 3, name: "Resolution"),
    ]
    public let ActionList = [
        Action(id: 1, phaseID: 1, name: "Generate Resources", details: "Eat salami beforehand"),
        Action(id: 2, phaseID: 1, name: "Acquire Cards", details: "DO NOT EAT SALAMI DURING THIS ACTION"),
        Action(id: 3, phaseID: 2, name: "Identify Target", details: "salami might be ok here"),
    ]
    public let RuleSets = [
        RuleSet(playerCount: 1, rules: "Exclude Wallace and Kim from the pool of available characters."),
        RuleSet(playerCount: 2, rules: "Exclude Wallace and Kim from the pool of available characters."),
        RuleSet(playerCount: 3, rules: "Include Wallace and Kim in the pool of available characters."),
        RuleSet(playerCount: 4, rules: "Include Wallace and Kim in the pool of available characters."),
    ]
    
    
    // MARK: User Input
    public var players = [Player]()
    
    
    // MARK: Game State
    var startingPlayer = 0
    var turnState = TurnState(player: 0, isFirstTurn: true, currentPhase: 1, currentAction: 1)
    
    
    // MARK: Getter Methods
    public func startingPlayerName() -> String {
        return players[startingPlayer].name
    }
    
    public func currentRuleset() -> String {
        let matchingRulesets = RuleSets.filter { $0.playerCount == players.count }
        
        return matchingRulesets.first!.rules
    }
    
    public func currentTurnPlayer() -> String {
        return players[turnState.player].name
    }
    
    public func currentPhaseName() -> String {
        let matchingPhases = PhaseList.filter { $0.id == turnState.currentPhase }
        
        return matchingPhases.first!.name
    }
    
    public func currentPhaseActions() -> [Action] {
        return ActionList.filter { $0.phaseID == turnState.currentPhase }
    }
    
    public func currentActionDetails() -> String {
        let matchingActions = ActionList.filter { $0.id == turnState.currentAction }
        
        return matchingActions.first!.details
    }
    
    
    // MARK: Setter Methods
    public func generateStartingPlayer() {
        startingPlayer = Int(arc4random_uniform(UInt32(players.count)))
        turnState.player = startingPlayer
    }
    
    public func prepareNextTurn() {
        let maxPlayerIndex = players.count - 1
        
        turnState.player = (turnState.player == maxPlayerIndex) ? 0 : turnState.player + 1
        turnState.currentPhase = 1
        turnState.currentAction = 1
        turnState.isFirstTurn = false // Yes this will be set more often than necessary, shush
    }
    
    public func nextAction(_ nextAction: Action) {
        let actions = currentPhaseActions()
        
        if (actions.index(where: { $0.id == nextAction.id}) == actions.count - 1) {
            // Phase is complete, shift to next phase
            turnState.currentPhase += 1
            
            // TODO: This feels super wonky, think we need to store a list of completed actions / phases or something
        }
        
    }
    
}
