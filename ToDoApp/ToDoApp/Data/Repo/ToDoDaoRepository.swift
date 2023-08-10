//
//  ToDoDaoRepository.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 10.08.2023.
//

import Foundation
import RxSwift

class ToDoDaoRepository {
    var toDoList = BehaviorSubject<[ToDo]>(value: [ToDo]())
    
    func saveToDo(toDo: String) {
        print("To do saved! -> \(toDo)")
    }
    
    func updateToDo(toDoID: Int, toDo: String) {
        print("To do updated! -> \(toDoID) - \(toDo)")
    }
    
    func loadAllToDos() {
        
        var toDos = [ToDo]()
        
        let toDo1 = ToDo(toDoID: 1, toDo: "Buy food 🥦🌽🍍")
        let toDo2 = ToDo(toDoID: 2, toDo: "Study Swift 👩🏻‍💻")
        let toDo3 = ToDo(toDoID: 3, toDo: "Take mock tests! 📝")
        
        toDos.append(toDo1)
        toDos.append(toDo2)
        toDos.append(toDo3)
        
        toDoList.onNext(toDos)
    }
    
    func deleteToDo(toDoID: Int) {
        print("To do deleted: \(toDoID)")
    }
    
    func search(toDo: String) {
        print("Search to do: \(toDo)")
    }
}
