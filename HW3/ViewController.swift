//
//  ViewController.swift
//  HW3
//
//  Created by Samuel MCDONALD on 1/30/17.
//  Copyright © 2017 Samuel MCDONALD. All rights reserved.
//

import UIKit
import CoreData

class ViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext :NSManagedObjectContext!
    //var toDoTableViewCell : ToDoTableViewCell!
    var toDoArray = [ToDo]()
    
    @IBOutlet var toDoTableView : UITableView!
    //MARK: - Interactivity MEthods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueListToEdit" {
            let indexPath = toDoTableView.indexPathForSelectedRow!
            let currentToDo = toDoArray[indexPath.row]
            let destVC = segue.destination as! DetailViewController
            destVC.currentToDo = currentToDo
            toDoTableView.deselectRow(at: indexPath, animated: true)}
    }
    
    //Mark: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return toDoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(cellId,forIndexPath: indexPath) as! TaskCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        //print(cell)
        let currentToDo = toDoArray[indexPath.row]
        cell.taskName!.text = currentToDo.taskName!
        if currentToDo.taskCompleted {
            cell.taskCompletion.isOn = true
            cell.completeLabel.text = "Completed!"
            cell.completeLabel.textColor = .green
        }else{
            cell.taskCompletion.isOn = false
            cell.completeLabel.text = "incomplete"
            cell.completeLabel.textColor = .red
        }
        cell.taskCompletion.isEnabled = false
        cell.taskPriority.isEnabled = false
        cell.dateLabel.text = String(describing: currentToDo.dateCreated!)
        cell.taskPriority.selectedSegmentIndex = Int(currentToDo.priorityZone)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let toDoToDelete = toDoArray[indexPath.row]
            managedContext.delete(toDoToDelete)
            appDelegate.saveContext()
            toDoArray = appDelegate.fetchAllToDos()
            toDoTableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.isEditing = false
        }
    }
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = appDelegate.persistentContainer.viewContext
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toDoArray = appDelegate.fetchAllToDos()
        print("Count \(toDoArray.count)")
        toDoTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
