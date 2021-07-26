//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Alexander Slobodjanjuk on 23.07.2021.
//

import UIKit
// Импортируем библиотеку Alamofire, установленную с помощью CocoaPods:
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем запрос. Для начала параметры:
        let paramsData: [String: Any] = ["id": "personNickname",
                                         "email": "internetEmail",
                                         "image_url": "https://picsum.photos/id/237/200/300",
                                         "_repeat": 10]
        let parameters: [String: Any] = ["token":"t5t1tivIZeHgQCUbUf2Ltw", "data": paramsData]

        // Теперь url:
        let url = "https://app.fakejson.com/q"

        // Выполняем запрос на следующей строке:
        AF.request(url, method: .post, parameters: parameters).responseJSON { (data) in

            // Все, что находится внутри этого блока, выполнится тогда, когда сервер вернет JSON
            // Наша переменная data как раз и хранит этот JSON, сделаем print и убедимся, что данные пришли:

            print(data)
        }
    }
}
