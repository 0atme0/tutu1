//
//  DetailViewCell.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 21.06.16.
//  Copyright © 2016 111. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {

    
    
    @IBOutlet weak var value: UITextField!
    @IBOutlet weak var label: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
