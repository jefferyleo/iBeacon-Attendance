//
//  FeedbackViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 5/25/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Provide Feedback"
        var mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setSubject("Feedback to Attendance")
        mail.setMessageBody("", isHTML: false)
        mail.setToRecipients(["jefferyleo93@hotmail.com"])
        presentViewController(mail, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!)
    {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            let sendMailErrorAlert = UIAlertView(title: "Mail Cancelled", message: "You've cancel the email. Try again to send the email.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        case MFMailComposeResultSaved.value:
            let sendMailErrorAlert = UIAlertView(title: "Mail Saved", message: "Look into draft and continue to send the email.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        case MFMailComposeResultSent.value:
            let sendMailErrorAlert = UIAlertView(title: "Mail Sent", message: "You've successfully sent to Apptendance.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        case MFMailComposeResultFailed.value:
            let sendMailErrorAlert = UIAlertView(title: "Mail send failure", message: "Check your phone or email configuration to try again.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        default:
            break
        }
        dismissViewControllerAnimated(true, completion: nil)
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
