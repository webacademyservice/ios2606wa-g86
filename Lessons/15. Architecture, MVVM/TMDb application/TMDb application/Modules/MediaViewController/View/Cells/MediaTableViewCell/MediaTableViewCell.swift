//
//  MediaTableViewCell.swift
//  TMDb application
//
//  Created by Alexander on 21.08.2021.
//

import UIKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 16
    }
    
    // MAK: - User Interface
    
    private func setupUI() {
        self.mediaTitleLabel.textColor = .white
        self.dateLabel.textColor = .white
        self.overviewLabel.textColor = .white
        
        self.selectionStyle = .none
    }
    
    func configureWith(imageURL: URL?, title: String?, releaseDate: String?, overviewText: String?) {
        self.mediaTitleLabel.text = title
        self.dateLabel.text = releaseDate
        self.overviewLabel.text = overviewText
        self.posterImageView.sd_setImage(with: imageURL, completed: nil)
        self.setupUI()
    }
    
}
