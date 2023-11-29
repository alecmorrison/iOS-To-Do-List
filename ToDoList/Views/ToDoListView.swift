//
//  ToDoListItemsView.swift
//  ToDoList
//
//  Created by Alec Morrison on 6/11/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    @State private var selectedItem: ToDoListItem
    
    init(userId: String){
        //users/<id>/todos/<entries>
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
        self.selectedItem = .init(id: "",
                                  title: "",
                                  dueDate: Date().timeIntervalSince1970,
                                  createdDate: Date().timeIntervalSince1970,
                                  isDone: true)
    }
    
    var body: some View {
        NavigationView{
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions{
                            Button{
                                // Delete
                                viewModel.delete(id: item.id)
                            }label: {
                                Text("Delete")
                            }
                            .tint(.red)
                            Button{
                                // EDIT
                                selectedItem = item
                                viewModel.showingEditItemView = true
                                
                            } label: {
                                Text("Edit")
                            }
                            .tint(.gray)
                        }
                        .sheet(isPresented: $viewModel.showingEditItemView){
                            EditItemView(newItemPresented: $viewModel.showingEditItemView, item: selectedItem)
                        }
                }
                .listStyle(PlainListStyle())
            }
            
            .navigationTitle("To Do List")
            .toolbar {
                Button{
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

struct ToDoListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "dcuUSttLIpU6TJfEMqHasZBERzd2")
    }
}
