//
//  SettingViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 5/24/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit
import Social

class SettingViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.reuseIdentifier ==  "Facebook"
        {
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
            {
                var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                fbShare.setInitialText("Apptendance is Awesome!")
                self.presentViewController(fbShare, animated: true, completion: nil)
            }
//            else
//            {
//                var alert = UIAlertController(title: "Accounts", message: "Please login to Facebook to continue.", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.reuseIdentifier ==  "Facebook"
        {
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
            {
                var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                fbShare.setInitialText("Apptendance is Awesome!")
                self.presentViewController(fbShare, animated: true, completion: nil)
            }
//            else
//            {
//                var alert = UIAlertController(title: "Accounts", message: "Please login to Facebook to continue.", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
        }
        else if cell?.reuseIdentifier == "Twitter"
        {
            if  SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
            {
                var tweetSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetSheet.setInitialText("Apptendance is Awesome!")
                self.presentViewController(tweetSheet, animated: true, completion: nil)
            } else {
                var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
