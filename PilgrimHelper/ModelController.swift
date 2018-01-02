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
    // TODO: The order of PhaseList and ActionList is very hardcoded atm, need to find a better way of structuring this
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
        Action(id: 4, phaseID: 3, name: "Destroy Ham", details: "uh"),
        Action(id: 5, phaseID: 3, name: "Underappreciate Obscure Band", details: "welp"),
        Action(id: 6, phaseID: 3, name: "Rotate Dentures", details: "sure thing"),
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
    var turnState = TurnState(player: 0, isFirstTurn: true, currentPhase: 0, currentAction: 0)
    
    
    // MARK: Getter Methods
    public func startingPlayerName() -> String {
        return players[startingPlayer].name
    }
    
    public func currentRuleset() -> String {
        let matchingRulesets = RuleSets.filter { $0.playerCount == players.count }
        
        return matchingRulesets.first!.rules
    }
    
    // MARK: Phase Getters
    public func currentPhase() -> Phase {
        return PhaseList[turnState.currentPhase]
    }
    
    public func currentPhaseName() -> String {
        return currentPhase().name
    }
    
    public func currentPhaseActions() -> [Action] {
        return ActionList.filter { $0.phaseID == currentPhase().id }
    }
    
    // MARK: Action Getters
    public func currentAction() -> Action {
        return ActionList[turnState.currentAction]
    }
    
    public func currentActionDetails() -> String {
        return currentAction().details
    }
    
    public func isLastActionInTurn() -> Bool {
        return turnState.currentAction == (ActionList.count - 1)
    }
    
    public func isFirstActionInPhase() -> Bool {
        return currentPhaseActions().first!.id == currentAction().id
    }
    
    public func isLastActionInPhase() -> Bool {
        return currentPhaseActions().last!.id == currentAction().id
    }
    
    // MARK: Turn Getters
    public func currentTurnPlayer() -> String {
        return players[turnState.player].name
    }
    
    public func currentTurnProgress() -> Float {
        return ((1.0 / Float(ActionList.count)) * (Float(currentAction().id) - 1.0))
    }
    
    
    // MARK: Setter Methods
    public func generateStartingPlayer() {
        startingPlayer = Int(arc4random_uniform(UInt32(players.count)))
        turnState.player = startingPlayer
    }
    
    public func prepareNextTurn() {
        let maxPlayerIndex = players.count - 1
        
        turnState.player = (turnState.player == maxPlayerIndex) ? 0 : turnState.player + 1
        turnState.currentPhase = 0
        turnState.currentAction = 0
        turnState.isFirstTurn = false // Yes this will be set more often than necessary, shush
    }
    
    public func prepareNextAction() {
        if isLastActionInTurn() {
            // Turn is complete, reset and exit
            prepareNextTurn()
            return
        }
        
        if (isLastActionInPhase()) {
            // Phase is complete, shift to next phase
            turnState.currentPhase += 1
        }
        
        turnState.currentAction += 1
    }
    
}
