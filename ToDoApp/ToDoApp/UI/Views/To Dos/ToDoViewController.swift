//
//  MainViewController.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 31.07.2023.
//

import UIKit

class ToDoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDoButtonTapped))
        navigationController?.navigationBar.tintColor = UIColor(named: "buttonColor")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonTapped))
        
    }
    
}

extension ToDoViewController {
    
    // add button
    @objc private func addToDoButtonTapped() {
        // navigate to save to do page
        let storyboard = UIStoryboard(name: String(describing: SaveToDoViewController.self), bundle: nil)
        
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: SaveToDoViewController.identifier) as? SaveToDoViewController {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
    }
    
    @objc private func trashButtonTapped() {
        // clear all to-dos!
        showAlert()
    }
    
    @IBAction func editToDoTapped() {
        // navigate to edit to do page

        let storyboard = UIStoryboard(name: String(describing: EditToDoViewController.self), bundle: nil)
        let toDo = ToDo(toDoID: 1, toDo: "Write code!")
        
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: EditToDoViewController.identifier) as? EditToDoViewController {
            destinationVC.toDo = toDo
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "‼️", message: "Do you wanna delete all of your to dos?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            // delete all todos
            print("All todos deleted.")
        }))
        self.present(alert, animated: true)
    }
}

