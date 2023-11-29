//
//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Alec Morrison on 6/11/23.
//

import SwiftUI

struct ToDoListItemView: View {
    let item: ToDoListItem
    @StateObject var viewModel = ToDoListItemViewViewModel()
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.title)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated,time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button{
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
            }
        }
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(id: "123",
                                    title: "Get Milk",
                                    dueDate: Date().timeIntervalSince1970,
                                    createdDate: Date().timeIntervalSince1970,
                                    isDone: true))
    }
}
