//
//  EditItemView.swift
//  ToDoList
//
//  Created by Alec Morrison on 7/8/23.
//

import SwiftUI

struct EditItemView: View {
    
    @ObservedObject var viewModel = EditItemViewViewModel()
    @Binding var newItemPresented: Bool
    
    let item: ToDoListItem
    
    init(newItemPresented: Binding<Bool>, item: ToDoListItem) {
        self._newItemPresented = newItemPresented
        self.item = item
        self.viewModel = EditItemViewViewModel(itemId: item.id, title: item.title, dueDate: Date(timeIntervalSince1970: item.dueDate))
    }


    
    var body: some View {
        VStack{
            
            Text("Edit Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())

                // Button
                TLButton(title: "Save", background: .pink){
                    if viewModel.canSave {
                        viewModel.itemId = item.id
                        viewModel.save()
                        newItemPresented = false
                        
                    } else{
                        viewModel.showAlert = true
                    }
                    
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please Fill in all Fields and Select a Proper Due Date"))
            }
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(newItemPresented: Binding(get:{
            return true
        }, set: { _ in
        }), item: .init(id: "123",
                        title: "Get Milk",
                        dueDate: Date().timeIntervalSince1970,
                        createdDate: Date().timeIntervalSince1970,
                        isDone: true))
    }
}

