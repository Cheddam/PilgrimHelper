//
//  StartViewController.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 26/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import UIKit

// Shift this please
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class StartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Element References
    @IBOutlet weak var NewPlayerTextField: UITextField!
    @IBOutlet weak var AddPlayerButton: UIButton!
    @IBOutlet weak var PlayerListTable: UITableView!
    @IBOutlet weak var NextStepButton: UIButton!
    
    var model: ModelController!
    
    
    // MARK: Table Config / Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerListCell", for: indexPath)
        
        cell.textLabel?.text = model.players[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = model.players[sourceIndexPath.row]
        
        model.players.remove(at: sourceIndexPath.row)
        model.players.insert(movedItem, at: destinationIndexPath.row)
        
        // tableView.reloadData() - Enable for debugging
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            model.players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if (model.players.count < model.MaxPlayerCount) {
                AddPlayerButton.isEnabled = true
            }
            
            toggleNextButton((model.players.count > 0))
        }
    }
    
    
    // MARK: Init / Exit Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        NextStepButton.backgroundColor = UIColor.gray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let kickoffViewController = segue.destination as? KickoffViewController {
            kickoffViewController.model = model
        }
    }


    // MARK: Element Event Handlers
    @IBAction func addNewPlayer(_ sender: UIButton) {
        if let newPlayerName = NewPlayerTextField.text {
            if (newPlayerName != "") {
                model.players.append(Player(newPlayerName))
            }
        }
        
        NewPlayerTextField.text = ""
        
        if (model.players.count >= model.MaxPlayerCount) {
            sender.isEnabled = false
        }
        
        toggleNextButton((model.players.count > 0))
        
        PlayerListTable.reloadData()
    }
    
    @IBAction func finishAddingPlayers(_ sender: Any) {
        self.dismissKeyboard()
    }
    
    
    // MARK: Helper Methods
    func toggleNextButton(_ enable: Bool) {
        NextStepButton.isEnabled = enable
        NextStepButton.backgroundColor = enable ? UIColor.blue : UIColor.gray
    }
    
}

