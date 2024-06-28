//
//  AdminDashboard.swift
//  projecttest
//
//  Created by Subash Gaddam on 2024-06-27.
//



import SwiftUI

struct AdminDashboard: View {
    @StateObject private var databaseManager = DatabaseManager()
    @State private var items: [AdminBookItem] = []
    @State private var newItemName = ""
    @State private var newItemAuthor = ""
    @State private var newItemDescription = ""
    @State private var newItemURL = ""
    @State private var isEditMode = false
    @State private var selectedItem: AdminBookItem?
    
    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    VStack(alignment: .leading) {
                        Text(item.bookname).font(.headline)
                        Text(item.Authorname).font(.headline)
                        Text(item.bookdescription).font(.subheadline)
                        
                        AsyncImage(url: URL(string: item.bookurl)) { phase in
                            switch phase {
                            case .empty:
                                Image(systemName: "photo")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            case .failure:
                                Image(systemName: "photo")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            @unknown default:
                                Image(systemName: "photo")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onTapGesture {
                        selectedItem = item
                        newItemName = item.bookname
                        newItemDescription = item.bookdescription
                        newItemAuthor = item.Authorname
                        newItemURL = item.bookurl
                        isEditMode = true
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .onAppear {
                databaseManager.fetchItems { fetchedItems in
                    self.items = fetchedItems
                }
            }
            
            HStack {
                TextField("Book Name", text: $newItemName)
                    .padding()
                TextField("Description", text: $newItemDescription)
                TextField("Author Name", text: $newItemAuthor)
                TextField("Image URL", text: $newItemURL)
                
                Button(isEditMode ? "Update" : "Add") {
                    if isEditMode, let item = selectedItem {
                        var updatedItem = item
                        updatedItem.bookname = newItemName
                        updatedItem.bookdescription = newItemDescription
                        updatedItem.Authorname = newItemAuthor
                        updatedItem.bookurl = newItemURL
                        databaseManager.updateItem(updatedItem)
                        isEditMode = false
                    } else {
                        let newItem = AdminBookItem(bookname: newItemName, Authorname: newItemAuthor, bookdescription: newItemDescription, bookurl: newItemURL)
                        databaseManager.addItem(newItem)
                    }
                    newItemName = ""
                    newItemDescription = ""
                    newItemAuthor = ""
                    newItemURL = ""
                    selectedItem = nil
                }
            }
            .padding()
        }
        .navigationTitle("Admin Dashboard")
        .navigationBarItems(trailing: EditButton())
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            databaseManager.deleteItem(item)
        }
        items.remove(atOffsets: offsets)
    }
}

struct AdminDashboard_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboard()
    }
}
