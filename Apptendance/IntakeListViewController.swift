//
//  IntakeListViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 4/13/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class IntakeListViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet var pvIntakeCode: UIPickerView!
    //var pickerString = NSArray() as AnyObject as! [String]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var query = PFQuery(className: "Timetable")
        query.findObjectsInBackgroundWithBlock
        {
                (objects:[AnyObject]?, error:NSError?) -> Void in
                if error == nil
                {
                    for object in objects! as [AnyObject]
                    {
                        //var counter: Int = 0
                        if !self.pickerString.containsObject(object["Intake"] as! String) {
                            self.pickerString.addObject(object["Intake"] as! String)
                            //to avoid the duplication of the same data in picker view
                            //self.pickerString.insertObject(object["Intake"] as! String, atIndex: counter)
                            //counter = counter + 1
                            //println("%@",self.pickerString.count)
                        }
                    }
                    self.pvIntakeCode.reloadAllComponents()
                }
                else
                {
                    NSLog("Error: %@ %@", error!, error!.userInfo!)
                }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "btnOK") {
            var dataPass = segue.destinationViewController as! SignUpViewController
            dataPass.txtIntake.text = lblSelectedItem.text
        }
    }
    @IBAction func btnOK(sender: AnyObject) {
        //self.IntakeListViewController.dismissViewControllerAnimated;:YES completion:nil
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
