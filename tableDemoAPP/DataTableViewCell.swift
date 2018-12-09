//
//  DataTableViewCell.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 06/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet var ProfileImageView: UIImageView!{
        didSet {
            ProfileImageView.layer.borderWidth = 1.0
            ProfileImageView.layer.masksToBounds = false
            ProfileImageView.layer.borderColor = UIColor.black.cgColor
            ProfileImageView.layer.cornerRadius = ProfileImageView.frame.height/2
            ProfileImageView.clipsToBounds = true
        }
    }
    @IBOutlet var fullNameLbl: UILabel!
    @IBOutlet var emailIDShowingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
