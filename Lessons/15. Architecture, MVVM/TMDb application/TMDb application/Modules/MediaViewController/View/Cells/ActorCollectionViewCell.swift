//
//  ActorCollectionViewCell.swift
//  TMDb application
//
//  Created by Alexander on 01.08.2021.
//

import UIKit
import SDWebImage
import os

class ActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    // MARK: - Class Life Circle

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cellImageView.layer.cornerRadius = self.cellImageView.frame.height / 2
    }
    
    // MARK: - Public
    
    func configureWith(actorName: String?, profilePath: String?) {
        self.cellTitleLabel.text = actorName
        self.loadImage(profilePath: profilePath)
        self.setupCell()
    }
    
    // MARK: - Private
    
    private func setupCell() {
        self.cellImageView.contentMode = .scaleAspectFit
    }
    
    private func loadImage(profilePath: String?) {

        guard let profilePath = profilePath else {
            os_log("RrofilePath is nil")
            return
        }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/original" + profilePath)
        self.cellImageView.sd_setImage(with: imageURL, completed: nil)
    }
}
