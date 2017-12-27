//
//  ViewController.swift
//  PilgrimHelper
//
//  Created by Garion Herman on 26/12/17.
//  Copyright © 2017 Edgar Industries. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Element References
    @IBOutlet weak var NewPlayerTextField: UITextField!
    @IBOutlet weak var AddPlayerButton: UIButton!
    @IBOutlet weak var PlayerListTable: UITableView!
    
    var model = Model()
    
    
    // MARK: Table Config / Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.Players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerListCell", for: indexPath)
        
        cell.textLabel?.text = model.Players[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = model.Players[sourceIndexPath.row]
        
        model.Players.remove(at: sourceIndexPath.row)
        model.Players.insert(movedItem, at: destinationIndexPath.row)
        
        // tableView.reloadData() - Enable for debugging
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            model.Players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if (model.Players.count < model.MaxPlayerCount) {
                AddPlayerButton.isEnabled = true
            }
        }
    }
    
    
    // MARK: Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: Element Event Handlers
    @IBAction func addNewPlayer(_ sender: UIButton) {
        if let newPlayer = NewPlayerTextField.text {
            if (newPlayer != "") {
                model.Players.append(newPlayer)
            }
        }
        
        NewPlayerTextField.text = ""
        
        if (model.Players.count >= model.MaxPlayerCount) {
            sender.isEnabled = false
        }
        
        PlayerListTable.reloadData()
    }
    
    
    // MARK: Other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

