//
//  MainViewController.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 31.07.2023.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var toDoSearchBar: UISearchBar!
    @IBOutlet weak var toDoTableView: UITableView!
    
    static let identifier = "ToDoViewControllerCell"
    let viewModel = ToDoViewModel()
    var toDoList = [ToDo]()
    var label = UILabel()
    var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoSearchBar.delegate = self
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        title = "To Do App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDoButtonTapped))
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonTapped))
        
        _ = viewModel.toDoList.subscribe(onNext: { toDos in
            self.toDoList = toDos
         
            self.toDoTableView.reloadData()
            self.isToDoListEmpty()
        })
        
        style()
        layout()
        generateActivityIndicator()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadAllToDos()
    }
}

extension ToDoViewController {
    
    @objc private func addToDoButtonTapped() {
        // navigate to save to do page
        let storyboard = UIStoryboard(name: String(describing: SaveToDoViewController.self), bundle: nil)
        
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: SaveToDoViewController.identifier) as? SaveToDoViewController {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
    }
    
    @objc private func trashButtonTapped() {
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "‼️", message: "Do you wanna delete all of your to dos?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.toDoList.removeAll()
            self.viewModel.deleteAllToDos()
            self.activityIndicator.startAnimating()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.activityIndicator.stopAnimating()
                self.toDoTableView.reloadData()
                self.label.isHidden = false
            }
            
            
        }))
        self.present(alert, animated: true)
    }
 
    private func generateActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
}


//MARK: - UITableView Delegate & DataSource Methods
extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDo = toDoList[indexPath.row].toDo
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoViewController.identifier, for: indexPath) as! ToDoTableViewCell
            
        cell.toDoLabel.text = toDo
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toDo = toDoList[indexPath.row]
        
        let storyboard = UIStoryboard(name: String(describing: EditToDoViewController.self), bundle: nil)
        
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: EditToDoViewController.identifier) as? EditToDoViewController {
            destinationVC.toDo = toDo
            navigationController?.pushViewController(destinationVC, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let toDoItem = toDoList[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
            
            let alert = UIAlertController(title: "Careful!", message: "Do you want to delete \(toDoItem.toDo)?", preferredStyle: .alert)
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            
            let okButton = UIAlertAction(title: "Yes", style: .destructive) { action in
                self.viewModel.deleteToDo(toDoID: toDoItem.toDoID)
                self.isToDoListEmpty()
            }
            
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func isToDoListEmpty() {
        label.isHidden = toDoList.count == 0 ? false : true
    }
}

//MARK: - UISearchBar Delegate Methods
extension ToDoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(toDo: searchText)
    }
}


//MARK: - Label
extension ToDoViewController {
    private func style() {
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "There's nothing to do here! Please click on the plus button to enter an item."
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textColor = .systemGray
    }
    
    private func layout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
}

