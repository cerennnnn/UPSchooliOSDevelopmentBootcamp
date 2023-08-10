//
//  EditToDoViewModel.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 10.08.2023.
//

import Foundation

class EditToDoViewModel {
    
    let toDoRepo = ToDoDaoRepository()
    
    func updateToDo(toDoID: Int, toDo: String) {
        toDoRepo.updateToDo(toDoID: toDoID, toDo: toDo)
    }
}
