//
//  TurnViewController.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 28/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import UIKit

class TurnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var model: ModelController!
    var currentActionList = [Action]()
    
    @IBOutlet weak var CurrentPlayerTitleLabel: UILabel!
    @IBOutlet weak var TurnProgressIndicator: UIProgressView!
    @IBOutlet weak var CurrentPhaseNameLabel: UILabel!
    @IBOutlet weak var PhaseStepListTable: UITableView!
    @IBOutlet weak var CurrentStepDetailsLabel: UILabel!
    @IBOutlet weak var SkipPhaseButton: UIButton!
    @IBOutlet weak var NextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTurn()
    }
    
    func setUpTurn() {
        //
        
        // Apply current player name to title
        CurrentPlayerTitleLabel.text = "\(model.currentTurnPlayer())'s Turn"
        
        // Apply first phase name and enable skipping
        CurrentPhaseNameLabel.text = "\(model.currentPhaseName()) Phase"
        
        // Apply steps for first phase
        currentActionList = model.currentPhaseActions()
        PhaseStepListTable.reloadData()
        // TODO: Reset height to avoid excess cell display?
        
        // Apply details for first step
        CurrentStepDetailsLabel.text = model.currentActionDetails() as String
        CurrentStepDetailsLabel.sizeToFit()
        
        // Reset state of buttons / progress indicator
        SkipPhaseButton.isEnabled = true
        SkipPhaseButton.backgroundColor = UIColor.orange
        
        NextStepButton.isEnabled = true
        NextStepButton.backgroundColor = UIColor.blue
        
        TurnProgressIndicator.progress = 0
    }
    
    // MARK: Table Config / Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentActionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionListCell", for: indexPath)
        let action = currentActionList[indexPath.row]
        let currentActionID = model.turnState.currentAction
        
        cell.textLabel?.text = action.name
        
        // Custom cell styling based on state
        if (action.id < currentActionID) {
            cell.backgroundColor = UIColor.green
            cell.textLabel?.textColor = UIColor.white
            cell.accessoryType = .checkmark
        } else if (action.id == currentActionID) {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (action.id > currentActionID) {
            cell.textLabel?.textColor = UIColor.gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = currentActionList[indexPath.row]
        let currentActionID = model.turnState.currentAction
        
        if (action.id == currentActionID) {
            
        }
    }

}
