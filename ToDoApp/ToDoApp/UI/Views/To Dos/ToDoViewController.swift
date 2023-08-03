//
//  MainViewController.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 31.07.2023.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var toDoCollectionView: UICollectionView!
    
    static let identifier = "ToDoViewController"
    var toDoList = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoCollectionView.delegate = self
        toDoCollectionView.dataSource = self
        
        title = "To Do App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDoButtonTapped))
        navigationController?.navigationBar.tintColor = UIColor(named: "buttonColor")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonTapped))
        
        collectionViewDesign()
        
        let toDo1 = ToDo(toDoID: 1, toDo: "Buy food 🥦🌽🍍")
        let toDo2 = ToDo(toDoID: 2, toDo: "Study Swift 👩🏻‍💻")
        let toDo3 = ToDo(toDoID: 3, toDo: "Take mock tests! 📝")
        
        toDoList.append(toDo1)
        toDoList.append(toDo2)
        toDoList.append(toDo3)
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
        // clear all to-dos!
        showAlert()
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
    
    private func collectionViewDesign() {
        let design = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2
        
        design.scrollDirection = .vertical
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        design.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        toDoCollectionView.collectionViewLayout = design
    }
    
    private func fadeCell(_ cell: UICollectionViewCell?) {
        UIView.animate(withDuration: 0.2, animations: {
            cell?.alpha = 0.0
        }) { (_) in
            cell?.alpha = 1.0
        }
    }

}

//MARK: - UICollectionView Delegate & DataSource Methods
extension ToDoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let toDo = toDoList[indexPath.row].toDo
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCollectionViewCell", for: indexPath) as! ToDoCollectionViewCell
        
        cell.toDoLabel.text = toDo
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        fadeCell(cell)
        
        let toDo = toDoList[indexPath.row]
        
        let storyboard = UIStoryboard(name: String(describing: EditToDoViewController.self), bundle: nil)
        
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: EditToDoViewController.identifier) as? EditToDoViewController {
            destinationVC.toDo = toDo
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
            return true // Silmeye izin vermek için true döndürün
        }
    
}
