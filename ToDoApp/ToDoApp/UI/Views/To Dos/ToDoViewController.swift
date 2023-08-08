//
//  MainViewController.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 31.07.2023.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var toDoSeaarchBar: UISearchBar!
    @IBOutlet weak var toDoCollectionView: UICollectionView!
    
    static let identifier = "ToDoViewController"
    var toDoList = [ToDo]()
    var filteredToDoList = [ToDo]()
    var label = UILabel()
    var isFiltering = false
    var isToDoDone = false 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoSeaarchBar.delegate = self
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
        
        style()
        layout()
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
            self.toDoList.removeAll()
            self.toDoCollectionView.reloadData()
            self.label.isHidden = false
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
}

//MARK: - UICollectionView Delegate & DataSource Methods
extension ToDoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredToDoList.count
        } else {
            return toDoList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let toDo = toDoList[indexPath.row].toDo
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "ToDoCollectionViewCell"), for: indexPath) as! ToDoCollectionViewCell
        
        cell.toDoLabel.text = toDo
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        cell.deleteToDoProtocol = self
        cell.toDoDoneProtocol = self
        cell.indexPath = indexPath
        cell.toDoList = toDoList
        cell.isToDoDone = isToDoDone

        cell.shake()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let toDo = toDoList[indexPath.row]
        
        let storyboard = UIStoryboard(name: String(describing: EditToDoViewController.self), bundle: nil)
        
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: EditToDoViewController.identifier) as? EditToDoViewController {
            destinationVC.toDo = toDo
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

//MARK: - DeleteToDoProtocol
extension ToDoViewController: DeleteToDoProtocol {
    func deleteToDo(_ indexPath: IndexPath) {
        let toDo = toDoList[indexPath.row]
        print("\(toDo.toDo) silindi.")
        
        // Animasyonu başlat
        UIView.animate(withDuration: 2.0, animations: {
            
        }) { (finished) in
            // Animasyon tamamlandığında yapılacaklar
            self.toDoList.remove(at: indexPath.row)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.toDoCollectionView.reloadData()
                if self.toDoList.isEmpty {
                    self.label.isHidden = false
                }
            }
        }
    }
}

//MARK: - DoneDataProtocol
extension ToDoViewController: ToDoDoneProtocol {
    func toDoDoneToggle(_ indexPath: IndexPath, _ isToDoDone: Bool) {
        self.isToDoDone.toggle()
        toDoCollectionView.reloadItems(at: [indexPath])
    }
    
}

//MARK: - shake animation extension
extension UICollectionViewCell {
    func shake() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        layer.add(shakeAnimation, forKey: "shake")
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

//MARK: - UISearchBar Delegate Methods
extension ToDoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        if searchText.isEmpty {
            isFiltering = false
        } else {
            isFiltering = true
        }
        
        filteredToDoList = toDoList.filter { $0.toDo.contains(searchText) }
        toDoCollectionView.reloadData()
        
    }
 
}

