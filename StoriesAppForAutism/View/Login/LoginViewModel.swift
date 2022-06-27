//
//  LoginViewModel.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 26.06.22.
//

import Foundation

class LoginViewModel {
    var email: String?
    var password: String?
    
    var loginFinished: (() -> ()) = { }
    var registerSelected: (() -> ()) = { }
    
    func setupProperties(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
    
    func login(completion: @escaping ((Bool) -> Void)) {
        guard let email = email, let password = password else { return }
        
        DatabaseService.shared.login(email: email, password: password) { [weak self] authResult in
            
            // if there's no auth result, then there was an error
            if let _ = authResult {
                completion(true)
                self?.loginFinished()
            } else {
                completion(false)
            }
        }
    }
}
