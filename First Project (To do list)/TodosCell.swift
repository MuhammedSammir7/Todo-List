//
//  TodosCell.swift
//  First Project (To do list)
//
//  Created by ios on 23/12/2023.
//

import UIKit

class TodosCell: UITableViewCell {

    @IBOutlet weak var todoTitleLable: UILabel!
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var todoCreationDateLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
