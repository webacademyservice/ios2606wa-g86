//
//  ViewController.swift
//  TableView - practice
//
//  Created by Alexander Slobodjanjuk on 11.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "TopicTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "TopicTableViewCell")
    }
}


extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return Topics.topicsList.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell") as? TopicTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: Topics.topicsList[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let topic = Topics.topicsList[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "TopicDetailsViewController") as? TopicDetailsViewController {

            viewController.text = topic.name
            viewController.imageName = topic.imageName

            self.navigationController?.present(viewController, animated: true, completion: nil)
        }

    }
}




