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
    @IBOutlet weak var CurrentStepDetailsViewContainer: UIView!
    @IBOutlet weak var SkipPhaseButton: UIButton!
    @IBOutlet weak var NextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Turn Details area (markdown view)
        let downView = try? DownView(frame: CurrentStepDetailsViewContainer.bounds)

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
    }
    
    func updateTurnView() {
        // Apply current player name to title
        CurrentPlayerTitleLabel.text = "\(model.currentTurnPlayer())'s Turn"
        
        // Update turn progress indicator
        let progress = model.currentTurnProgress()
        TurnProgressIndicator.setProgress(progress, animated: progress > 0)
        
        // Apply phase name
        CurrentPhaseNameLabel.text = "\(model.currentPhaseName()) Phase"
        
        // Apply steps for current phase
        currentActionList = model.currentPhaseActions()
        PhaseStepListTable.reloadData()
        // TODO: Reset height to avoid excess cell display?
        
        // Apply details for current step and fix sizing
        CurrentStepDetailsLabel.text = model.currentActionDetails() as String
        CurrentStepDetailsLabel.sizeToFit()
        
        // Enable / disable phase skipping as needed
        if (model.isFirstActionInPhase()) {
            SkipPhaseButton.isEnabled = true
            SkipPhaseButton.backgroundColor = UIColor.orange
        } else {
            SkipPhaseButton.isEnabled = false
            SkipPhaseButton.backgroundColor = UIColor.gray
        }
        
        // Set 'next step' button label based on what it'll do
        NextStepButton.titleLabel!.text = (model.isLastActionInTurn()) ? "Next Turn" : "Next Step"
    }
    
    // MARK: Table Config / Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentActionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionListCell", for: indexPath)
        let action = currentActionList[indexPath.row]
        let currentActionID = model.currentAction().id
        var cellState = CellState.UPCOMING_ACTION
        
        cell.textLabel?.text = action.name
        
        // Custom cell styling based on state
        if (action.id < currentActionID) {
            cellState = CellState.COMPLETED_ACTION
        } else if (action.id == currentActionID) {
            cellState = CellState.CURRENT_ACTION
        }
        
        applyCellState(cell, state: cellState)
        
        return cell
    }

    @IBAction func triggerNextStep(_ sender: Any) {
        model.prepareNextAction()
        updateTurnView()
    }
    
    // Sets appropriate styles for a cell based on its state
    func applyCellState(_ cell: UITableViewCell, state: CellState) {
        switch state {
            case .COMPLETED_ACTION:
                cell.textLabel?.textColor = UIColor.green
                cell.accessoryType = .checkmark
                cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
                break
            
            case .CURRENT_ACTION:
                cell.textLabel?.textColor = UIColor.black
                cell.accessoryType = .none
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                break
            
            case .UPCOMING_ACTION:
                cell.textLabel?.textColor = UIColor.gray
                cell.accessoryType = .none
                cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
                break
        }
    }
    
}
