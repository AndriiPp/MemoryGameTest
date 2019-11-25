//
//  UserCell.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/24/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
