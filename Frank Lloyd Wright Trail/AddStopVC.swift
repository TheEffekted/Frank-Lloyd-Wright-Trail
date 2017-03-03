//
//  AddStopVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

class AddStopVC: UITableViewController, UIPickerViewDelegate{
    var cellTapped = false
    var currentRow = -1
    var currentSection = -1
    var type: StopActions?
    var genStop: GenericStop?
    var mealStop: MealStop?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genStop = GenericStop(name : "")
        mealStop = MealStop(name: "")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Add Stops"
        
        let button = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.rightBarButtonItem = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        default:
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCellWithIdentifier("name") as! NameCell
            cell.stopName.placeholder = "Stop Name"
            return cell
        case (1,0):
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! LabelCell
            cell.label.text! = "Date"
            return cell
        case (1,1):
            let cell = tableView.dequeueReusableCellWithIdentifier("datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .Date
            cell.datePicker.tag = 11
            return cell
        case (2,0):
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! LabelCell
            cell.label.text! = "Start Time"
            return cell
        case (2,1):
            let cell = tableView.dequeueReusableCellWithIdentifier("datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .Time
            cell.datePicker.tag = 21
            return cell
        case (2,2):
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! LabelCell
            cell.label.text! = "End Time"
            return cell
        case (2,3):
            let cell = tableView.dequeueReusableCellWithIdentifier("datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .Time
            cell.datePicker.tag = 23
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if currentRow != indexPath.row{
        cellTapped = true
            currentRow = indexPath.row + 1
            currentSection = indexPath.section
        }
        else{
            cellTapped = false
            currentRow = -1
            currentSection = -1
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func doneSelected(sender: UIBarButtonItem){
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! NameCell
        if let name = cell.stopName.text{
            
            if type == .meal{
                mealStop?.name = name
                TripModel.shared.stops.append(mealStop!)
                print("Meal Name = \(mealStop?.name)")
                print("Meal Date = \(mealStop?.date)")
                print("Meal Start Time = \(mealStop?.startTime)")
                print("Meal End Time = \(mealStop?.endTime)")
            }
            else {
                genStop?.name = name
                TripModel.shared.stops.append(genStop!)
                print("Gen Name = \(genStop?.name)")
                print("Gen Date = \(genStop?.date)")
                print("Gen Start Time = \(genStop?.startTime)")
                print("Gen End Time = \(genStop?.endTime)")
            }
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        if indexPath.section != 0 && (indexPath.row == 1 || indexPath.row == 3) {
            if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped{
                return 75
            }
            
            else{
                return 0
            }
        }
        
    
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if  section == 2 {
            if type == .meal {
                 return "TIME FOR MEAL"
            }
            else{
                return "TIME FOR STOP"
            }
        }
        return nil
    }
    
    
    // datechanged function
    @IBAction func dateChanged(sender: UIDatePicker) {
        if type == .meal{
            switch sender.tag {
                case 11:
                mealStop!.date = sender.date
                case 21:
                mealStop!.startTime = sender.date
                case 23:
                mealStop!.endTime = sender.date
                default:
                break
            }
            
        }
        else{
            switch sender.tag {
            case 11:
                genStop!.date = sender.date
            case 21:
                genStop!.startTime = sender.date
            case 23:
                genStop!.endTime = sender.date
            default:
                break
            }
        }
        
        
    }

 

}