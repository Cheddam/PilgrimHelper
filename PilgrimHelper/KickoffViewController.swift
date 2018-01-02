//
//  KickoffViewController.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 28/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import UIKit

class KickoffViewController: UIViewController {
    
    var model: ModelController!

    @IBOutlet weak var PlayerCountTitleLabel: UILabel!
    @IBOutlet weak var StartingPlayerNameLabel: UILabel!
    @IBOutlet weak var GameRulesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the player count in the title
        PlayerCountTitleLabel.text = "\(model.players.count) Player Game"
        
        // Pick a starting player
        model.generateStartingPlayer()
        
        // Apply this player to StartingPlayerNameLabel
        StartingPlayerNameLabel.text = model.startingPlayerName() as String
        
        // Apply the appropriate GameRules (and resize text area)
        GameRulesLabel.text = model.currentRuleset() as String
        GameRulesLabel.sizeToFit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let turnViewController = segue.destination as? TurnViewController {
            turnViewController.model = model
        }
    }
    
    

}
