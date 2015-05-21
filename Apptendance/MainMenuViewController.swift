//
//  MainMenuViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 4/26/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class MainMenuViewController: UITabBarController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogout(sender: AnyObject)
    {
        var alertView = UIAlertView(title: "Logout", message: "Are you sure you want to logout?", delegate: self, cancelButtonTitle: "Cancel")
        alertView.addButtonWithTitle("Sure")
        alertView.show()
    }
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int)
    {
        if(buttonIndex == 0)
        {
            return
        }
        else
        {
            PFUser.logOut()
            self.navigationController?.popViewControllerAnimated(true)
            //self.dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("gotoLogout", sender: self)
            //self.presentViewController(LoginViewController(), animated: true, completion: nil)
        }
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
