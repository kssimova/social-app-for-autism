//
//  DatabaseService.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 4.06.22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import AVFAudio

class DatabaseService {
    static let shared = DatabaseService()
    
    let dataBase = Database.database()
    let usersReference: DatabaseReference!
    let storiesReference: DatabaseReference!
    
    private init() {
        usersReference = dataBase.reference(withPath: "users")
        storiesReference = dataBase.reference(withPath: "stories")
    }
    
    func login(email: String, password: String, completionBlock : @escaping ((AuthDataResult?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, _ in
            completionBlock(authResult)
        }
    }
    
    func createUser(user: User, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: user.emailAddress, password: password) { authResult, error in
            if let result = authResult, let id = Auth.auth().currentUser?.uid {
                user.setUserId(userId: id)
                self.addUserToDatabase(user: user)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    
    func addUserToDatabase(user: User) {
        if let userDictionary = user.dict {
            usersReference.childByAutoId().setValue(userDictionary) { error, _ in }
        }
    }
    
    func createStory(baseStoryModel: BaseStoryModel, pages: [Page], questions: [Question], completion: @escaping ((Bool) -> Void)) {
        var parameters = [String : Any]()
        
        // Create a dictionary with the parameters to upload to the database
        if let bsModel = baseStoryModel.dict {
            parameters = bsModel
            
            var pagesValue = [[String : Any]]()
            for page in pages {
                if let dict = page.dict {
                    pagesValue.append(dict)
                }
            }
            parameters["pages"] = pagesValue
            
            var questionsValue = [[String : Any]]()
            for question in questions {
                if let dict = question.dict {
                    questionsValue.append(dict)
                }
            }
            parameters["qustions"] = questionsValue
        }
        
        storiesReference.childByAutoId().setValue(parameters) { error, dbref in
            // If there's an error then the upload to database has failed
            if let _ = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
//    func retrieveUserEmail(userName : String, completionBlock : ((_ userEmail : String) -> Void)){
//       // var userEmail : String!
//        print("#### retrieving userEmail")
//        dataBaseReference.child("usernameEmailLink/\(userName)").observeSingleEvent(of: .value, with: {(snap) in
//            print("#### Snap received -> \(snap)")
//
//        //userEmail = snap.value! //This will give you the email ID for the user.
//
//         /*
//           completionBlock(snap.value!)   // A even better way if this is all this function does.
//         */
//        })
//      // print(userEmail)
//
//    }
}

extension Encodable {
    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}
