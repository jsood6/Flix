//
//  MovieCell.swift
//  flix
//
//  Created by jsood on 2/4/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var movie: Movie! {
        didSet {
            titleLabel.text = movie["title"] as? String
            overviewLabel.text = movie["overview"] as? String
            posterImage.text = movie["overview"] as? String
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
