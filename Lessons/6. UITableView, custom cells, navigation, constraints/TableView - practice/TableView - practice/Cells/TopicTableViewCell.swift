//
//  TopicTableViewCell.swift
//  TableView - practice
//
//  Created by Alexander Slobodjanjuk on 11.07.2021.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLablel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(with topic: Topic) {
        self.cellImageView.image = UIImage(named: topic.imageName)
        self.cellTitleLablel.text = topic.name
    }
    
}
