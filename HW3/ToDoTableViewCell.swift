//
//  ToDoTableViewCell.swift
//  HW3
//
//  Created by Samuel MCDONALD on 1/31/17.
//  Copyright © 2017 Samuel MCDONALD. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet var taskName         :UILabel!
    @IBOutlet var taskCompletion   :UISwitch!
    @IBOutlet var completeLabel    :UILabel!
    @IBOutlet var dateLabel        :UILabel!
    @IBOutlet var taskPriority     :UISegmentedControl!
    
    @IBAction func valueChanged(taskCompletion: UISwitch) {
        if taskCompletion.isOn {
            completeLabel.text      = "Completed!"
            completeLabel.textColor = UIColor.green
            
        }else {
            completeLabel.text      = "Incomplete"
            completeLabel.textColor = UIColor.red
        }

    }
}
