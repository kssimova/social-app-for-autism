//
//  RegistrationViewModel.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 5.06.22.
//

import Foundation

struct RegistrationViewModel {
    var user: User
    var password: String
    
    func register(completion: @escaping ((Bool, Error?) -> Void)) {
        DatabaseService.shared.createUser(user: user, password: password) { (isSuccessful, error) in
            print("#### Create user callback called in RegistrationViewModel, isSuccessful -> \(isSuccessful), error -> \(error)")
            completion(isSuccessful, error)
        }
    }
}
