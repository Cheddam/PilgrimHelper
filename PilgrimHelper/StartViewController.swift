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
    
    var modelController: ModelController!
    
    
    // MARK: Table Config / Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerListCell", for: indexPath)
        
        cell.textLabel?.text = modelController.players[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = modelController.players[sourceIndexPath.row]
        
        modelController.players.remove(at: sourceIndexPath.row)
        modelController.players.insert(movedItem, at: destinationIndexPath.row)
        
        // tableView.reloadData() - Enable for debugging
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            modelController.players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if (modelController.players.count < modelController.MaxPlayerCount) {
                AddPlayerButton.isEnabled = true
            }
        }
    }
    
    
    // MARK: Init / Exit Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ???
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let kickoffViewController = segue.destination as? KickoffViewController {
            kickoffViewController.modelController = modelController
        }
    }


    // MARK: Element Event Handlers
    @IBAction func addNewPlayer(_ sender: UIButton) {
        if let newPlayer = NewPlayerTextField.text {
            if (newPlayer != "") {
                modelController.players.append(newPlayer)
            }
        }
        
        NewPlayerTextField.text = ""
        
        if (modelController.players.count >= modelController.MaxPlayerCount) {
            sender.isEnabled = false
        }
        
        PlayerListTable.reloadData()
    }
    
    @IBAction func finishAddingplayers(_ sender: UIButton) {
        self.dismissKeyboard()
    }
    
    // MARK: Other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

