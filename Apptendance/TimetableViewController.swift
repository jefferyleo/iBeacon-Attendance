//
//  TimetableViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 5/7/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//
import Foundation
import UIKit

class TimetableViewController: PFQueryTableViewController, UITextFieldDelegate{
    
    override func viewDidLoad()
    {
        self.navigationController?.navigationBar.translucent = false //to avoid the table view cover by the navigation bar
        self.navigationController?.navigationBar.topItem?.title = "Timetable"
        super.viewDidLoad()
        var timetable = PFQuery(className: "Timetable")
        var timetableArray:NSMutableArray = []
        timetable.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil
            {
                for object in objects! as [AnyObject]
                {
                    timetableArray.addObject((object["Time"] as? String)!)
                }
            }
        }
    }
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Timetable" //Parse Class Name
        self.textKey = "Time"
        self.pullToRefreshEnabled = false
        self.paginationEnabled = false
    }
    
    override func queryForTable() -> PFQuery
    {
        let displayIntake = PFUser.currentUser()!["IntakeCode"] as? String
        
        //print the whole date
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateString = dateFormatter.stringFromDate(NSDate())
        
        //get the day of the week
        let dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dayFormatter.stringFromDate(NSDate())
        let day = dayOfWeekString.substringToIndex(advance(dayOfWeekString.startIndex, 3))
        
        var fullDate = "\(day.uppercaseString) \(dateString)"
        
        //querying what to get from the table
        var query = PFQuery(className: "Timetable")
        query.whereKey("Intake", equalTo: displayIntake!)
        query.whereKey("Day", equalTo: fullDate)
        query.orderByAscending("Time")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TimetableCustomCell!
        
        if cell == nil
        {
            cell = TimetableCustomCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        //extract the values from the PFObject and display it on the cell
        if let time = object?["Time"] as? String
        {
            cell?.lblTime.text = time
        }
        
        if let room = object?["Room"] as? String
        {
            cell?.lblClassroom.text = room
        }
        
        if let subjectCode = object?["SubjectCode"] as? String
        {
            cell?.lblSubjectCode.text = subjectCode
        }
        
        if let lecturerName = object?["LecturerName"] as? String
        {
            cell?.lblLecturerName.text = lecturerName
        }
//        if (cell?.lblLecturerName.text == nil)
//        {
//            var alertView = UIAlertView(title: "No scheduled classes on today.", message: "", delegate: self, cancelButtonTitle: "OK")
//        }
        return cell
    }
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let displayIntake = PFUser.currentUser()!["IntakeCode"] as? String
//        
//        //print the whole date
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        var dateString = dateFormatter.stringFromDate(NSDate())
//        
//        //get the day of the week
//        let dayFormatter = NSDateFormatter()
//        dayFormatter.dateFormat = "EEEE"
//        let dayOfWeekString = dayFormatter.stringFromDate(NSDate())
//        let day = dayOfWeekString.substringToIndex(advance(dayOfWeekString.startIndex, 3))
//        
//        var fullDate = "\(day.uppercaseString) \(dateString)"
//        
//        var timetable = PFQuery(className: "Timetable")
//        timetable.whereKey("Intake", equalTo: displayIntake!)
//        timetable.whereKey("Day", equalTo: fullDate)
//        
//        var timetableArray:NSMutableArray = []
//        timetable.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
//            if error == nil
//            {
//                for object in objects! as [AnyObject]
//                {
//                    timetableArray.addObject((object["Time"] as? String)!)
//                }
//            }
//        }
//        if timetableArray.count < 1
//        {
//            let alertView = UIAlertView(title: "No Scheduled classes on today.", message: "", delegate: self, cancelButtonTitle: "OK")
//            alertView.show()
//        }
//        //println(timetableArray.count)
//        return timetableArray.count
//    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as? TimetableHeaderCell
        headerCell?.backgroundColor = UIColor(red: 58.0/255.0, green: 194.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        //print the whole date
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateString = dateFormatter.stringFromDate(NSDate())
        
        //get the day of the week
        let dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dayFormatter.stringFromDate(NSDate())
        let day = dayOfWeekString.substringToIndex(advance(dayOfWeekString.startIndex, 3))
        
        headerCell?.lblDate.text = " \(day.uppercaseString) \(dateString)"
        return headerCell
    }
}