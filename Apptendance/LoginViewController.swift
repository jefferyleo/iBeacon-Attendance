//
//  LoginViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 4/21/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, PFLogInViewControllerDelegate {

    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var switchRemember: UISwitch!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnSignIn(sender: AnyObject)
    {
        self.DismissKeyboard()
        if txtUsername.text.isEmpty || txtPassword.text.isEmpty
        {
            let alertView = UIAlertView(title: "Error", message: "Cannot blank", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }
        else if txtUsername.text != "" && txtPassword.text != ""
        {
            SwiftSpinner.show("Signing In...", animated: true)
            PFUser.logInWithUsernameInBackground(txtUsername.text, password: txtPassword.text, block: { (user:PFUser?, error:NSError?) -> Void in
                if(error != nil)
                {
                    SwiftSpinner.hide()
                    var errorCode = error?.code
                    switch errorCode!
                    {
                    case 100:
                        var alertView = UIAlertView(title: "No connection found", message: "Try Again!", delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                        break
                    case 101:
                        var alertView = UIAlertView(title: "Incorrect Username or Password", message: "Try Again!", delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                        break
                    case 209:
                        var alertView = UIAlertView(title: "Invalid Token", message: "Ignore!", delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                        break
                    default:
                        break
                    }
                }
                else
                {
                    SwiftSpinner.hide()
                    let fileManager = NSFileManager.defaultManager()
                     let documentsPath : AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0]
                    let destinationPath:NSString = documentsPath as! NSString
                    
                    if(!fileManager.fileExistsAtPath(destinationPath as String))
                    {
                        var error:NSError?
                        let url = "http://webspace.apiit.edu.my/intake-timetable/download_timetable/timetableCSV.zip"
                        let data = NSData(contentsOfFile: url, options:nil, error:nil)
                        if(data != nil)
                        {
                            let writePath = destinationPath.stringByAppendingPathComponent(url)
                            fileManager.copyItemAtPath(writePath, toPath: destinationPath as String, error: &error)
                        }
                        if(error == nil)
                        {
                            println("Timetable file is saved")
                        }
                        else
                        {
                            println("Error occured")
                        }
                    }
                    else
                    {
                        println("Files is existed")
                    }
                    self.performSegueWithIdentifier("gotoLogin", sender: self)
                }
            })
        }
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
        return true
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
