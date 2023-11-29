//
//  EditItemViewViewModel.swift
//  ToDoList
//
//  Created by Alec Morrison on 7/8/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class EditItemViewViewModel: ObservableObject{
    @Published var itemId = ""
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false

    init() {}
    
    init(itemId: String, title: String, dueDate: Date) {
        self.itemId = itemId
        self.title = title
        self.dueDate = dueDate
    }


    
    func save() {
        //save
        guard canSave else{
            return
        }
        
        // Get current User Id
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        
        // Create Model
        let newItem = ToDoListItem(id: itemId,
                                   title: title,
                                   dueDate: dueDate.timeIntervalSince1970,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false)
        
        
        //Save Model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(itemId)
            .setData(newItem.asDictionary())
        
        
        
        
    }
    
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
