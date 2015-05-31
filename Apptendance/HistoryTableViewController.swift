//
//  HistoryTableViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 5/30/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class HistoryTableViewController: PFQueryTableViewController {
    var attendanceArray:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false //to avoid the table view cover by the navigation bar
        
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.blackColor()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = CustomFunction.getUsername()
    }
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Attendance" //Parse Class Name
        self.textKey = "SubjectCode"
        self.pullToRefreshEnabled = false
        self.paginationEnabled = false
    }
    
    override func queryForTable() -> PFQuery
    {
        let displayIntake = PFUser.currentUser()!["IntakeCode"] as? String
        
        //querying what to get from the table
        var query = PFQuery(className: "Attendance")
        query.whereKey("Username", equalTo: CustomFunction.getUsername())
        query.whereKey("IntakeCode", equalTo: displayIntake!)
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! HistoryCustomCell!
        
        if cell == nil
        {
            cell = HistoryCustomCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        var attendance = PFQuery(className: "Attendance")
        attendance.whereKey("Username", equalTo: CustomFunction.getUsername())
        attendance.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil
            {
                for object in objects! as [AnyObject]
                {
                    var subjectCode = object["SubjectCode"] as? String
                    if !self.attendanceArray.containsObject(object["SubjectCode"] as! String)
                    {
                        self.attendanceArray.addObject(object["SubjectCode"] as! String)
                        //cell.lblSubjectCode.text = self.attendanceArray.objectAtIndex(indexPath.row) as? String
//                        for items in self.attendanceArray
//                        {
//                            cell.lblSubjectCode.text = items as? String
//                        }
                    }
                    cell.lblSubjectCode.text = subjectCode
                }
            }
        }
        
        var attendanceCount = PFQuery(className: "Attendance")
        attendanceCount.whereKey("Username", equalTo: CustomFunction.getUsername())
        attendanceCount.whereKey("IntakeCode", equalTo: CustomFunction.getCurrentIntake())
        attendanceCount.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil
            {
                var attendanceCountArray:NSMutableArray = []
                for object in objects! as [AnyObject]
                {
                    attendanceCountArray.removeAllObjects()
                    attendanceCountArray.addObject(object)
                    //attendanceCountArray.addObject(object["SubjectCode"] as! String)
                    println(attendanceCountArray.count)
                    println(object["SubjectCode"] as! String)
                    var total:Int = 0
                    cell.lblTotalClass.text = "\(total) / 24"
                }
                println(attendanceCountArray.count)
            }
        }
//        var percentage:Double = 0
//        let totalClass:Int? = cell.lblTotalClass.text?.toInt()
//        percentage = Double((totalClass! / 24) * 100)
//        cell.lblPercentage.text = "\(percentage)"
        
        return cell
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var attendance = PFQuery(className: "Attendance")
        attendance.whereKey("Username", equalTo: CustomFunction.getUsername())
        attendance.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil
            {
                for object in objects! as [AnyObject]
                {
                    var subjectCode = object["SubjectCode"] as? String
                    if !self.attendanceArray.containsObject(object["SubjectCode"] as! String)
                    {
                        self.attendanceArray.addObject(object["SubjectCode"] as! String)
                    }
                }
            }
        }
        return self.attendanceArray.count
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as? HistoryHeaderCellTableViewCell
        headerCell?.backgroundColor = UIColor(red: 58.0/255.0, green: 194.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        headerCell?.lblIntake.text = "UC3F1410SE"
        return headerCell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as? HistoryHeaderCellTableViewCell
        headerCell?.backgroundColor = UIColor(red: 58.0/255.0, green: 194.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        headerCell?.lblIntake.text = "\(CustomFunction.getCurrentIntake())"
        return headerCell?.lblIntake.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
