//
//  Model.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 27/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import Foundation

class Model {
    
    // MARK: Static Data
    public let PhaseList = [Phase(id: 1, name: "Acquisition"), Phase(id: 2, name: "Combat"), Phase(id: 3, name: "Resolution")]
    public let ActionList = [Action(id: 1, phaseID: 1, name: "Generate Resources"), Action(id: 2, phaseID: 2, name: "Acquire Card(s)")]
    public let RuleSets = [RuleSet(playerCount: 1, rules: "NO RULES FAM")]
    public let MaxPlayerCount = 4;
    
    
    // MARK: User Input
    public var Players = [String]()
    
}
