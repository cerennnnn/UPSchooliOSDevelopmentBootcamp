//
//  EditToDoViewController.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 31.07.2023.
//

import UIKit

class EditToDoViewController: UIViewController {
    
    @IBOutlet weak var editToDoTextField: UITextField!
    
    static let identifier = "EditToDoViewController"
    var toDo: ToDo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleTextField()
        
        if let toDo {
            editToDoTextField.text = toDo.toDo
        }
    }

    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let toDoID = toDo?.toDoID else { return }
        
        if let editedToDo = editToDoTextField.text, editToDoTextField.text != nil {
            updateToDo(toDoID: toDoID, toDo: editedToDo)
            showAlert()
        }
    }
    
    private func updateToDo(toDoID: Int, toDo: String) {
        print("To do updated! -> \(toDoID) - \(toDo)")
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "To do updated! ✏️", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }

}

extension EditToDoViewController: StyleTextFieldProtocol {
    func styleTextField() {
        editToDoTextField.clipsToBounds = true
        editToDoTextField.layer.cornerRadius = 15
        editToDoTextField.layer.borderColor = UIColor.systemGray3.cgColor
        editToDoTextField.layer.borderWidth = 1
    }
}
