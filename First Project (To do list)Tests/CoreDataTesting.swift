//
//  CoreDataTesting.swift
//  First Project (To do list)Tests
//
//  Created by ios on 02/10/2024.
//

import XCTest
@testable import First_Project__To_do_list_
import CoreData

final class CoreDataTesting: XCTestCase {

    var persistentContainer : NSPersistentContainer!
    var todosStorage: TodoStorage!
     
    override func setUpWithError() throws {
        
        persistentContainer = NSPersistentContainer(name: "TodosModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError?{
                fatalError("Failed to lead in-memory store: \(error)")
            }
        }
        todosStorage = TodoStorage.shared
    }
     
    override func tearDownWithError() throws {
        persistentContainer = nil
        todosStorage = nil
    }
    func test_delete_all_todos(){
        TodoStorage.shared.deleteAllTodos()
        XCTAssertEqual(TodoStorage.shared.getTodos().count , 0)
    }
    func test_store_todo(){
        let todo1 = Todo(title: "first todo", details: "first details")
        TodoStorage.shared.storeTodo(todo: todo1)

        XCTAssertEqual(TodoStorage.shared.getTodos().count , 2 , "the values is repeated" )
    }
    func test_store_redandunt_todo(){
        let todo1 = Todo(title: "first todo", details: "first details")
        TodoStorage.shared.storeTodo(todo: todo1)
        
        XCTAssertEqual(TodoStorage.shared.getTodos().count , 1 , "the values is repeated" )
    }
    
    func test_fetch_todo(){
        XCTAssertNotNil(TodoStorage.shared.getTodos(), "No Todos")
    }
    
    func test_update_todo(){
        let todoUpdate = Todo(title: "updated todo", details: "updated details")
        TodoStorage.shared.updateTodo(todo: todoUpdate, index: 1)
        XCTAssertEqual(TodoStorage.shared.getTodos()[1].title , todoUpdate.title , "Todo didn't update")
    }
    
    func test_delete_todo() {

        let todo1 = Todo(title: "first todo", details: "first details")
        TodoStorage.shared.storeTodo(todo: todo1)

        TodoStorage.shared.deleteTodo(index: 0)

        XCTAssertEqual(TodoStorage.shared.getTodos().count, 0, "Todo was not deleted correctly")
    }

 }
