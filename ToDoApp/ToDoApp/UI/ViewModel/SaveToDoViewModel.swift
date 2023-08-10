//
//  SaveToDoViewModel.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 10.08.2023.
//

import Foundation

class SaveToDoViewModel {
    
    let toDoRepo = ToDoDaoRepository()
    
    func saveToDo(toDo: String) {
        toDoRepo.saveToDo(toDo: toDo)
    }
    
}
