//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Alec Morrison on 6/11/23.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        // Try to Log User In
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func validate() -> Bool {
        // Reset Error Message
        errorMessage = ""
        
        //Check for empty Fields
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please Fill in All Fields"
            return false
        }
        
        // Check Valid Email
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please Enter Valid Email"
            return false
        }
        return true
    }
    
    
}


