//
//  detailViewController.swift
//  HW3
//
//  Created by Samuel MCDONALD on 1/30/17.
//  Copyright © 2017 Samuel MCDONALD. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController{
    @IBOutlet var saveButton       :UIBarButtonItem!
    @IBOutlet var taskName         :UITextField!
    @IBOutlet var taskCompletion   :UISwitch!
    @IBOutlet var completeLabel    :UILabel!
    @IBOutlet var dateLabel        :UILabel!
    @IBOutlet var taskPriority     :UISegmentedControl!
    
    
    
    var currentToDo :ToDo?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext :NSManagedObjectContext!
    
    
    
    
    //MARK: - Core Methods
    
    func display(toDo: ToDo) {
        taskName.text = toDo.taskName
        taskCompletion.isOn = toDo.taskCompleted
        if toDo.taskCompleted{
            completeLabel.text = "Completed!"
            completeLabel.textColor = .green
        }else{
            completeLabel.text = "Incomplete"
            completeLabel.textColor = .red
        }
        taskPriority.selectedSegmentIndex = Int(toDo.priorityZone)
        dateLabel.text = String(describing: toDo.dateCreated)
    }
    
    func setToDoValues(toDo: ToDo) {
        toDo.taskCompleted = taskCompletion.isOn
        toDo.priorityZone = Int16(taskPriority.selectedSegmentIndex)
        toDo.taskName = taskName.text
        if let _ = toDo.dateCreated {
            toDo.dateUpdated = NSDate()
        }else{
            toDo.dateCreated = NSDate()
        }
        
       /* contact.firstName = firstNameTextField.text
        contact.lastName = lastNameTextField.text
        contact.phoneNumber =  phoneTextField.text
        if let _ = currentContact {
            contact.dateUpdated = NSDate()
        }else{
            contact.dateEnetered = NSDate()
        }
*/
        
    }
    
    func createToDo(){
        let newToDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: managedContext) as! ToDo
        setToDoValues(toDo: newToDo)
        appDelegate.saveContext()
        
    }
    
    
    func editToDo(toDo: ToDo) {
        setToDoValues(toDo: toDo)
        appDelegate.saveContext()
    }
    
    //Mark: - interactivity methods
    
    @IBAction func savePressed(button: UIBarButtonItem) {
        if let toDo = currentToDo{
            editToDo(toDo: toDo)
        } else {
            createToDo()
        }
        self.navigationController!.popViewController(animated: true)
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = appDelegate.persistentContainer.viewContext
        if let toDo = currentToDo{
            display(toDo: toDo)
        }
    }
}

