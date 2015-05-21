//
//  ViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 3/31/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var switchRemember: UISwitch!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if (identifier == "gotoLogin")
        {
            if txtUsername.text.isEmpty || txtPassword.text.isEmpty
            {
                let alertView = UIAlertView(title: "Error", message: "Cannot blank", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
                return false
            }
            else if txtUsername.text != "" && txtPassword.text != ""
            {
                activityIndicator.startAnimating()
                PFUser.logInWithUsernameInBackground(txtUsername.text, password: txtPassword.text, block: { (user:PFUser?, error:NSError?) -> Void in
                    if(error == nil)
                    {
                        self.activityIndicator.stopAnimating()
                        self.performSegueWithIdentifier("gotoLogin", sender: self)
                    }
                    else
                    {
                        self.activityIndicator.stopAnimating()
                        var errorCode = error?.code
                        switch errorCode!
                        {
                        case 101:
                            var alertView = UIAlertView(title: "Incorrect Username or Password", message: "Try Again!", delegate: self, cancelButtonTitle: "OK")
                            alertView.show()
                            break
                        default:
                            break
                        }
                    }
                })
                return true
            }
        }
        return true
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}