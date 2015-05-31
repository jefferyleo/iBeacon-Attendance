//
//  SignUpViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 4/11/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit
import Foundation

class SignUpViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtIntake: UITextField!
    @IBOutlet var btnCreateAccount: UIButton!
    @IBOutlet var pvIntakeCode: UIPickerView!
    var pickerString:NSMutableArray = []
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    //var pickerString = NSArray() as AnyObject as! [String]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var query = PFQuery(className: "Timetable")
        var limit:NSInteger = 1000
        var skip:NSInteger = 0
        query.limit = limit
        query.skip = skip
        query.orderByAscending("Intake")
        query.findObjectsInBackgroundWithBlock
            {
                (objects:[AnyObject]?, error:NSError?) -> Void in
                if error == nil
                {
//                    self.pickerString.removeAllObjects()
//                    println(objects!.count)
//                    for object in objects! as [AnyObject]
//                    {
//                        var intakeCode = object["Intake"] as? String
//                        if !self.pickerString.containsObject(object["Intake"] as! String) {
//                            self.pickerString.addObject(object["Intake"] as! String)
//                            
//                        }
//                        println(object["Intake"] as! String)
//                    }
//                    self.pvIntakeCode.reloadAllComponents()
                    skip += limit
                    query.limit = limit
                    query.skip = skip
                    query.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                        if error == nil
                        {
                            for object in objects! as [AnyObject]
                            {
                                var intakeCode = object["Intake"] as? String
                                if !self.pickerString.containsObject(object["Intake"] as! String)
                                {
                                    self.pickerString.addObject(object["Intake"] as! String)
    
                                }
                            }
                            self.pvIntakeCode.reloadAllComponents()
                        }
                        else
                        {
                            NSLog("Error: %@ %@", error!, error!.userInfo!)
                        }
                    })
                }
                else
                {
                    NSLog("Error: %@ %@", error!, error!.userInfo!)
                }
        }
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        self.txtEmail.delegate = self
        self.txtIntake.delegate = self
        txtIntake.enabled = false
        txtIntake.enabled = false
        // Do any additional setup after loading the view.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    @IBAction func btnCreateAccount(sendfder: AnyObject)
    {
        if txtUsername.text.isEmpty && txtPassword.text.isEmpty && txtEmail.text.isEmpty && txtIntake.text.isEmpty
        {
            let alertView = UIAlertView(title: "Cannot Blank", message: "All Fields Required", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }
        else if txtUsername.text != "" && txtPassword.text != "" && txtEmail.text != "" && txtIntake.text != ""
        {
            //btnCreateAccount.enabled = false
            SwiftSpinner.show("Signing Up...", animated: true)
            var user = PFUser()
            
            user.username = txtUsername.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            user.password = txtPassword.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            user.email = txtEmail.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            user.setObject(txtIntake.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), forKey: "IntakeCode")
            
            user.signUpInBackgroundWithBlock
            {
                (succeeded, error) -> Void in
                if error == nil
                {
                    SwiftSpinner.hide()
                    var alertView = UIAlertView(title: "User Signed Up", message: "You can now go to sign in", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                }
                else
                {
                    SwiftSpinner.hide()
                    var errorCode = error?.code
                    switch errorCode!
                    {
                        case 124:
                            var alertView = UIAlertView(title: "Session Timeout.", message: "Reopen the application.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                            break
                        case 200:
                            var alertView = UIAlertView(title: "The username is missing.", message: "Please fill in your username.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                            break
                        case 201:
                            var alertView = UIAlertView(title: "The password is missing.", message: "Please fill in your password.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                            break
                        case 202:
                            var alertView = UIAlertView(title: "The username is exist.", message: "Please change to another username.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                            break
                        case 203:
                            var alertView = UIAlertView(title: "The email is exist.", message: "Please change to another email.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                        break
                        case 204:
                            var alertView = UIAlertView(title: "The email is missing.", message: "Please fill in your email.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                            break
                        case 209:
                            var alertView = UIAlertView(title: "Invalid Session.", message: "Reopen the application.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                            break
                        default:
                            var alertView = UIAlertView(title: "Unknown Error.", message: "Reopen the application.", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                        break
                    }
                }
            }
        }
        btnCreateAccount.enabled = true
    }
    
    func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == txtUsername)
        {
            txtUsername.resignFirstResponder()
        }
        else if (textField == txtPassword)
        {
            txtPassword.resignFirstResponder()
        }
        else if(textField == txtEmail)
        {
            txtEmail.resignFirstResponder()
        }
        else if(textField == txtIntake)
        {
            txtIntake.resignFirstResponder()
        }
        return true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        //println(self.pickerString.count)
        return self.pickerString.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //println(self.pickerString[row])
        return self.pickerString[row] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var selectedItem = self.pickerString.objectAtIndex(row) as! String
        txtIntake.text = selectedItem
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
