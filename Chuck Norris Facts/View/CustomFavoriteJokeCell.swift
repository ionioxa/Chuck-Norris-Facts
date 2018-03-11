//
//  CustomFavoriteJokeCell.swift
//  Chuck Norris Facts
//
//  Created by Ion Ioxa on 2018-03-04.
//  Copyright © 2018 Ion Ioxa. All rights reserved.
//

import UIKit

class CustomFavoriteJokeCell: UITableViewCell {

    
    @IBOutlet weak var favoriteJoke: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
