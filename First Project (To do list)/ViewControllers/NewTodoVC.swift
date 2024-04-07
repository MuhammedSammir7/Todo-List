//
//  NewTodoVC.swift
//  First Project (To do list)
//
//  Created by ios on 04/01/2024.
//

import UIKit
class NewTodoVC: UIViewController {

    var iscreationScreen = true
    var editedTodo : Todo?
    var editedTodoIndex : Int?
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var todoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTextView.text = ""
        if iscreationScreen == false{
            mainButton.setTitle("تعديل", for: .normal)
            navigationItem.title = "تعديل مهمة"
            
            if let todo = editedTodo {
                titleTextField.text = todo.title
                detailsTextView.text = todo.details
                todoImageView.image = todo.image
                
            }
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeImageButton(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
    }
    
    
    
    
    @IBAction func addButton(_ sender: Any) {
        
        if iscreationScreen {
            let alert = UIAlertController(title: "اضافة مهمة جديدة", message: "سيتم اضافة مهمة جديدة", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "اضافة المهمة", style: UIAlertAction.Style.destructive, handler: { action in
                let date = NSDate()
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
                var dateString = dateFormatter.string(from: date as Date)
                let todo = Todo(title: self.titleTextField.text!,image: self.todoImageView.image, details: self.detailsTextView.text, date: "\(dateString)")
                NotificationCenter.default.post(name: NSNotification.Name("NewTodoAdded"), object: nil, userInfo: ["AddedTodo":todo]);
                
                self.tabBarController?.selectedIndex = 0
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                
            }))
            alert.addAction(UIAlertAction(title: "الفاء", style: .cancel))

            self.present(alert, animated: true, completion: nil)
            
            
        }else {
            //editing button needs to be ubdated
            let alert = UIAlertController(title: "تعديل المهمة", message: "هل انت متاكد من رغبتك في تعديل هذه المهمة؟", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "تعديل", style: .destructive,handler: { action in
                let date = NSDate()
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
                var dateString = dateFormatter.string(from: date as Date)
                let todo = Todo(title: self.titleTextField.text!,image: self.todoImageView.image,details: self.detailsTextView.text, date: "\(dateString)")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentTodoEdited") , object: nil,userInfo: ["editedTodo": todo , "editedTodoIndex": self.editedTodoIndex])
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "الغاء", style: .cancel))
            self.present(alert, animated: true)
            
        }
        
    }
    
}

extension NewTodoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true)
        todoImageView.image = image
    }
}
