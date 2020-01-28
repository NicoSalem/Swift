//
//  tableVC.swift
//  Enigma
//
//  Created by Salem, Nicholas on 11/26/19.
//  Copyright © 2019 Salem, Nicholas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class celll : UITableViewCell
{
    
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var notes: UITextView!
    
}

class tableVC: UITableViewController {
    
    var Enigma: [NSManagedObject] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Enigma"
        updateFromModel()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Enigma.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! celll
        let item = Enigma[indexPath.row]
        //        cell.textLabel?.text = item.value(forKeyPath: "title") as? String
        //        cell.detailTextLabel?.text = item.value(forKeyPath: "password") as? String
        //        cell.location.text = item.value(forKeyPath: "title") as? String
        //        cell.price.text = item.value(forKeyPath: "password") as? String
        //        cell.rating.text = item.value(forKeyPath: "rating") as? String
        cell.question.text = item.value(forKeyPath: "question") as? String
        cell.notes.text = item.value(forKeyPath: "notes") as? String
        return cell
        //coment
    }
    
    @IBAction func onToggleEditting(_ sender: UIBarButtonItem) {
        setEditing(!isEditing, animated: true)
    }
    
    
    func updateFromModel() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        
        do {
            Enigma = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch requested media. \(error), \(error.userInfo)")
        }
    }
    
    func saveEntity(question: String, notes: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedContext)!
        
        let ent = NSManagedObject(entity: entity, insertInto: managedContext)
        ent.setValue(question, forKeyPath: "question")
        
        // if we had 2 strings to save we would set the value for artist here as well:
        ent.setValue(notes, forKeyPath: "notes")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    // disallow swipe deletion when not in edit mode
    
    #if !DEBUG
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return tableView.isEditing ? .delete : .none
    }
    #endif
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let entry = Enigma[indexPath.row] as? Entity {
                deletionAlert(title: entry.question!) { _ in
                    self.deleteIt(entry: entry)
                }
            }
        }
    }
    
    
    @IBAction func onAddBtn(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "question notes", message: "save your thoughts on questions to help you answer them correctly", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let titleTextField = alert.textFields?[0],
                let question = titleTextField.text else { return }
            
            
            guard let pwrdTextField = alert.textFields?[1],
                let notes = pwrdTextField.text else { return }
            
            
            self.saveEntity(question: question, notes: notes)
            self.updateFromModel()
            self.tableView.reloadData()
            
        }
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "question"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "notes"
        })
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    func getObjectContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func deleteIt (entry: Entity) {
        let context = getObjectContext()
        if let _ = Enigma.firstIndex(of: entry)  {
            context.delete(entry)
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not delete the item. \(error), \(error.userInfo)")
            }
        }
        updateFromModel()
        tableView.reloadData()
    }
    
    func deletionAlert(title: String, completion: @escaping (UIAlertAction) -> Void) {
        
        let alertMsg = "Are you sure you want to delete \(title)? This cannot be undone!"
        let alert = UIAlertController(title: "Warning", message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
