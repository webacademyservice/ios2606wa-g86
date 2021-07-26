//
//  DataManager.swift
//  UserDefaults Lesson 8
//
//  Created by Oleksandr Slobodianiuk on 15.07.2021.
//

import Foundation

struct DataManager {
    
    private let userDefaults = UserDefaults.standard
    
    // Сохранение данных:
    
    func save(_ value: Any?, for key: String) {
        self.userDefaults.setValue(value, forKey: key)
    }
    
    func save(_ user: User, for key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            self.save(data, for: key)
        } catch {
            print("Unable to Encode User (\(error))")
        }
    }
    
    // Извлечение данных:
    
    func getUserName(for key: String) -> String? {
        return self.userDefaults.string(forKey: key)
    }
    
    func getUser(for key: String) -> User? {
        
        guard let data = self.userDefaults.data(forKey: key) else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch  {
            print("Unable to Decode User (\(error))")
            return nil
        }
    }

    func getStringsArray(for key: String) -> [String] {
        return self.userDefaults.stringArray(forKey: key) ?? [String]()
    }

    // Удаление данных:

    func deleteValue(for key: String) {
        self.userDefaults.removeObject(forKey: key)
    }
}
