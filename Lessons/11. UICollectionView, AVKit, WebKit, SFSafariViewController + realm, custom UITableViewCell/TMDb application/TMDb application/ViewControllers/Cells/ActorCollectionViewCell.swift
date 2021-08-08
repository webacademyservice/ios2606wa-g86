//
//  ActorCollectionViewCell.swift
//  TMDb application
//
//  Created by Alexander on 01.08.2021.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cellImageView.layer.cornerRadius = self.cellImageView.frame.height / 2
    }
    
    func configureWith(actorName: String?, imageURL: String?) {
        self.cellTitleLabel.text = actorName
    }

}
