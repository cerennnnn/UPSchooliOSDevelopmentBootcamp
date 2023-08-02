//
//  SaveToDoViewController.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 31.07.2023.
//

import UIKit

protocol StyleTextFieldProtocol {
    func styleTextField()
}

class SaveToDoViewController: UIViewController {
    
    @IBOutlet weak var toDoTextField: UITextField!
    
    static let identifier = "SaveToDoViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add To Do"
        navigationController?.navigationBar.prefersLargeTitles = true
    
        styleTextField()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let toDo = toDoTextField.text, toDoTextField.text != "" {
            saveToDo(toDo: toDo)
            showAlert()
        }
    }
    
    private func saveToDo(toDo: String) {
        print("To do saved! -> \(toDo)")
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "New to do added! ✅", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension SaveToDoViewController: StyleTextFieldProtocol {
    func styleTextField() {
        toDoTextField.clipsToBounds = true
        toDoTextField.layer.cornerRadius = 15
        toDoTextField.layer.borderColor = UIColor.systemGray3.cgColor
        toDoTextField.layer.borderWidth = 1
    }
}
