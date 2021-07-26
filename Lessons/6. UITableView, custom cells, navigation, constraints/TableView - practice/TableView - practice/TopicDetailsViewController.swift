//
//  TopicDetailsViewController.swift
//  TableView - practice
//
//  Created by Alexander Slobodjanjuk on 11.07.2021.
//

import UIKit

class TopicDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!

    var text = ""
    var imageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage(named: self.imageName)
        self.topicLabel.text = self.text
    }

}
