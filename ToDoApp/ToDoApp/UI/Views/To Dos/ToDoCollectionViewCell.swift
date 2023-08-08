//
//  ToDoCollectionViewCell.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 3.08.2023.
//

import UIKit

protocol DeleteToDoProtocol {
    func deleteToDo(_ indexPath: IndexPath)
}

protocol ToDoDoneProtocol {
    func toDoDoneToggle(_ indexPath: IndexPath, _ isToDoDone: Bool)
}

class ToDoCollectionViewCell: UICollectionViewCell {
    
    var indexPath: IndexPath?
    var deleteToDoProtocol: DeleteToDoProtocol?
    var toDoDoneProtocol: ToDoDoneProtocol?
    var isToDoDone: Bool?
    var toDoList = [ToDo]()
    var attributedText: NSAttributedString?
    
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let indexPath = indexPath else { return }
        guard let isToDoDone = isToDoDone else { return }
        
        print("isToDoDone: \(isToDoDone)")
        print("clicked toDo: \(toDoList[indexPath.row].toDo)")
        
        if isToDoDone {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .normal)
            attributedText = NSAttributedString(string: toDoList[indexPath.row].toDo, attributes: [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: UIColor.systemGray
            ])
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), for: .normal)
            attributedText = NSAttributedString(string: toDoList[indexPath.row].toDo)
        }
        
        toDoLabel.attributedText = attributedText
        
        toDoDoneProtocol?.toDoDoneToggle(indexPath, isToDoDone)
        fadeTappedButton(sender)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        guard let indexPath = indexPath else { return }
        
        deleteToDoProtocol?.deleteToDo(indexPath)
        fadeTappedButton(sender)
    }
    
    private func fadeTappedButton(_ sender: UIButton) {
        sender.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
}

