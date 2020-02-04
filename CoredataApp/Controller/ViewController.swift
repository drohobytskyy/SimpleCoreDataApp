//
//  ViewController.swift
//  CoredataApp
//
//  Created by @rtur drohobytskyy on 04/02/2020.
//  Copyright © 2020 @rtur drohobytskyy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: - properties
    @IBOutlet weak var tableView: UITableView!
    
    var entities: [Entity] = [Entity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            let entities =  try DataService.context.fetch(fetchRequest)
            self.entities = entities
            self.tableView.reloadData()
        } catch {
            
        }
    }

    // MARK: - actions
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New entity", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        let action = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (action) in
            
            let name = alert.textFields?.first?.text!
            let age = alert.textFields?.last?.text!
            
            let entity = Entity(context: DataService.context)
            entity.name = name
            entity.age = Int16(age!)!
            DataService.saveContext()
            self.entities.append(entity)
            self.tableView.reloadData()
        }
        
        let cancelACtion = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (_) in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(cancelACtion)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - confrom to TableView protocols
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = entities[indexPath.row].name!
        cell.detailTextLabel?.text = String(entities[indexPath.row].age)
        
        return cell
    }
}

