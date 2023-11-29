//
//  ToDoListVIewViewModel.swift
//  ToDoList
//
//  Created by Alec Morrison on 6/11/23.
//

import Foundation
import FirebaseFirestore

/// ViewModel for list of items view
/// Primary tab
class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingEditItemView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    
    // Delete to do list Item
    func delete(id: String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
        
    }
}
