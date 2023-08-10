//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 11.08.2023.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
