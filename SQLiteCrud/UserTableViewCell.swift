//
//  UserTableViewCell.swift
//  SQLiteCrud
//
//  Created by ksolves on 07/01/20.
//  Copyright © 2020 ksolves. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var textfirstName: UILabel!
    @IBOutlet weak var textLastName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
