//
//  TodoDetailsVC.swift
//  First Project (To do list)
//
//  Created by ios on 23/12/2023.
//

import UIKit

class TodoDetailsVC: UIViewController {

    var todo: Todo!
    var index : Int!
    @IBOutlet weak var TodoImageView: UIImageView!
    @IBOutlet weak var TodoTitleLable: UILabel!
    @IBOutlet weak var DetailsLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if todo.image != nil {
            TodoImageView.image = todo.image
        }else {
            TodoImageView.image = UIImage(named: "five")
        }
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(currentTodoEdited), name: NSNotification.Name("CurrentTodoEdited"), object: nil)

    }
    @objc func currentTodoEdited(notification : Notification){
        if let myTodo = notification.userInfo?["editedTodo"] as? Todo {
            self.todo = myTodo
            setupUI()
        }
    }
    func setupUI(){
        DetailsLable.text = todo.details
        TodoTitleLable.text = todo.title
        TodoImageView.image = todo.image
    }
    @IBAction func editTodoButtonClicked(_ sender: Any) {

        if let viewController = storyboard?.instantiateViewController(identifier: "NewTodoVC") as? NewTodoVC {
            
            viewController.iscreationScreen = false
            viewController.editedTodo = todo
            viewController.editedTodoIndex = index
            navigationController?.pushViewController(viewController, animated: true)
            
           
        }
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Todo", message: "هل انت متاكد من رغبتك في حذف هذا العنصر؟", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "حذف", style: UIAlertAction.Style.destructive,handler: { action in
            NotificationCenter.default.post(name: NSNotification.Name("todoDelete"), object: nil,userInfo: ["deletedTodoIndex": self.index])
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "الغاء", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true)
        
    }
    
}
