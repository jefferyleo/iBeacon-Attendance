//
//  TimetableCustomCell.swift
//  Apptendance
//
//  Created by jeffery leo on 5/13/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class TimetableCustomCell: PFTableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblClassroom: UILabel!
    @IBOutlet weak var lblSubjectCode: UILabel!
    @IBOutlet weak var lblLecturerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
