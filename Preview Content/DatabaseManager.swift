//
//  DatabaseManager.swift
//  projecttest
//
//  Created by Subash Gaddam on 2024-06-27.
//

import SwiftUI

import Foundation

class DatabaseManager: ObservableObject {
    func fetchItems(completion: @escaping ([AdminBookItem]) -> Void) {
        // Simulate fetching items from a database
        let sampleItems = [
            AdminBookItem(bookname: "Sample Book 1", Authorname: "Author 1", bookdescription: "Description 1", bookurl: "https://example.com/image1.jpg"),
            AdminBookItem(bookname: "Sample Book 2", Authorname: "Author 2", bookdescription: "Description 2", bookurl: "https://example.com/image2.jpg")
        ]
        completion(sampleItems)
    }
    
    func addItem(_ item: AdminBookItem) {
        // Simulate adding an item to a database
        print("Item added: \(item)")
    }
    
    func updateItem(_ item: AdminBookItem) {
        // Simulate updating an item in a database
        print("Item updated: \(item)")
    }
    
    func deleteItem(_ item: AdminBookItem) {
        // Simulate deleting an item from a database
        print("Item deleted: \(item)")
    }
}

struct AdminBookItem: Identifiable {
    var id = UUID()
    var bookname: String
    var Authorname: String
    var bookdescription: String
    var bookurl: String
}

