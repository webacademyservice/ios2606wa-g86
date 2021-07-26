//
//  ViewController.swift
//  UserDefaults Lesson 8
//
//  Created by Oleksandr Slobodianiuk on 14.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userFullNameTextField: UITextField!
    @IBOutlet weak var userAgeTextField: UITextField!
    
    @IBOutlet weak var isMarriedSwitch: UISwitch!
        
    let userDefaultsManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Установим название контроллеру:
        self.title = "UserDefaults"

        // Устанавливаем в текстфилд значение имени по ключу FirstUser:
        self.userNameTextField.text = self.userDefaultsManager.getUserName(for: "FirstUser")

        // Добавляем тап по екрану, для того чтобы клавиатура уходила:
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions

    @IBAction func saveUserButtonPressed(_ sender: Any) {
        
        let user = User(name: self.userFullNameTextField.text,
                        age: Int(self.userAgeTextField.text ?? "0"),
                        isMarried: self.isMarriedSwitch.isOn)
        self.userDefaultsManager.save(user, for: "MainUser")
    }
    
    @IBAction func displaySavedDataPressed(_ sender: Any) {
        
        guard let user = self.userDefaultsManager.getUser(for: "MainUser") else { return }
        let nameString: String = user.name ?? ""
        let ageString: String = String(describing: user.age ?? 0)
        let isMarriedString: String = String(describing: user.isMarried ?? false)
        
        let message = """
            Name: \(nameString)
            Age: \(ageString)
            Married: \(isMarriedString)
        """
        
        let allertController = UIAlertController(title: "Main user:",
                                                 message: message,
                                                 preferredStyle: .alert)
        
        allertController.addAction(UIAlertAction(title: "Ok",
                                                 style: .default,
                                                 handler: nil))
        
        self.present(allertController, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userDefaultsManager.save(textField.text, for: "FirstUser")
        self.view.endEditing(true)
        return true
    }
}
