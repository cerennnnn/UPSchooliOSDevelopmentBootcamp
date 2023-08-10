//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 10.08.2023.
//

import Foundation
import RxSwift

class ToDoViewModel {
    
    let toDoRepo = ToDoDaoRepository()
    var toDoList = BehaviorSubject<[ToDo]>(value: [ToDo]())

    init() {
        self.toDoList = toDoRepo.toDoList
    }

    func loadAllToDos() {
        toDoRepo.loadAllToDos()
    }
    
    func deleteToDo(toDoID: Int) {
        toDoRepo.deleteToDo(toDoID: toDoID)
        loadAllToDos()
    }
    
    func search(toDo: String) {
        toDoRepo.search(toDo: toDo)
    }
}
