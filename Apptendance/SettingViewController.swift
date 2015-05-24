//
//  SettingViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 5/24/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController
{
    override func viewDidLoad()
    {
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
}
