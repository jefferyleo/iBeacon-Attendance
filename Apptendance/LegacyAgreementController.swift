//
//  LegacyAgreementController.swift
//  Apptendance
//
//  Created by jeffery leo on 5/25/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class LegacyAgreementController: UIViewController {

    @IBOutlet var SwipeLeft: UISwipeGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Legacy Agreement"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
