//
//  DataTypes.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 26/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import Foundation


struct Phase {
    let id: Int
    let name: String
}

struct Action {
    let id: Int
    let phaseID: Int
    var name: String
}

struct RuleSet {
    let playerCount: Int
    let rules: String
}
