//
//  TodosVC.swift
//  First Project (To do list)
//
//  Created by ios on 22/12/2023.
//

import UIKit
import CoreData

class TodosVC: UIViewController {
    
    var todosArray:[Todo] = [
    ]
    @IBOutlet weak var todosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todosArray = TodoStorage.getTodos()
        // New Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(NewTodoAdded), name: NSNotification.Name("NewTodoAdded"), object: nil)
        
        // Edit Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(currentTodoEdited), name: NSNotification.Name("CurrentTodoEdited"), object: nil)
        
        // Delete Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(todoDeleted), name: NSNotification.Name("todoDelete"), object: nil)
        
        
        todosTableView.dataSource = self
        todosTableView.delegate = self
    }
    
    @objc func NewTodoAdded(notification : Notification){
        
        if let myTodo = notification.userInfo?["AddedTodo"] as? Todo {
            todosArray.append(myTodo)
            todosTableView.reloadData()
            TodoStorage.storeTodo(todo: myTodo)
        }
    }
    @objc func currentTodoEdited(notification : Notification){
        if let todo = notification.userInfo?["editedTodo"] as? Todo {
            if let index = notification.userInfo?["editedTodoIndex"] as? Int{
                todosArray[index] = todo
                todosTableView.reloadData()
                TodoStorage.updateTodo(todo: todo, index: index)
            }
        }
        
    }
    @objc func todoDeleted(notification : Notification){
        if let index = notification.userInfo?["deletedTodoIndex"] as? Int{
            todosArray.remove(at: index)
            todosTableView.reloadData()
            TodoStorage.deleteTodo(index: index)
        }
    }
    
}

extension TodosVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodosCell") as! TodosCell
        cell.todoTitleLable.text = todosArray[indexPath.row].title
        if todosArray[indexPath.row].image != nil {
            cell.todoImageView.image = todosArray[indexPath.row].image
        }else {
            cell.todoImageView.image = UIImage(named: "five")
            
        }
        cell.todoCreationDateLable.text = "\(todosArray[indexPath.row].date)"
        cell.todoImageView.layer.cornerRadius = cell.todoImageView.frame.width / 2
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todo = todosArray[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "DetailsVC") as? TodoDetailsVC
        if let viewControler = vc {
            viewControler.todo = todo
            viewControler.index = indexPath.row
            navigationController?.pushViewController(viewControler, animated: true)
        }
    }
     
}
