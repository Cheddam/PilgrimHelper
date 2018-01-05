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
        Phase(id: 1, name: "Main Deck Elimination"),
        Phase(id: 2, name: "Acquisition"),
        Phase(id: 3, name: "Combat"),
        Phase(id: 4, name: "Resolution"),
    ]
    public let ActionList = [
        Action(id: 1, phaseID: 1, name: "Eliminate Card(s) (Optional)", details: "You may eliminate the top card of one or both of the Main Decks (next to the Evil Ex card). Eliminated cards are removed from the game and set aside. Useful for removing cards that aren't useful to you or are useful to your opponents. You must make your decision based only on the currently visible side of the cards."),
        Action(id: 2, phaseID: 2, name: "Generate Resources", details: "Use the story side of the Action Cards in your hand to generate resources. The resource type and amount is designated by the symbol and number on the top left of the card. Some cards may generate additional resources when played with Matching Drama cards."),
        Action(id: 3, phaseID: 2, name: "Acquire Cards", details: "Spend the resources you have generated to acquire new cards from the Plotline. The resource type / cost of these cards is designated by the symbol and number in the top right of the card."),
        Action(id: 4, phaseID: 3, name: "Identify Target", details: "salami might be ok here"),
        Action(id: 5, phaseID: 4, name: "Destroy Ham", details: "uh"),
        Action(id: 6, phaseID: 4, name: "Underappreciate Obscure Band", details: "welp"),
        Action(id: 7, phaseID: 4, name: "Rotate Dentures", details: "sure thing"),
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
    
    // TODO: Is this the best way to coerce Ints into Floats?
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
