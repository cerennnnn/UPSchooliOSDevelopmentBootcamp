//
//  People.swift
//  ToDoApp
//
//  Created by Ceren Güneş on 31.07.2023.
//

import Foundation

class ToDo {
    var toDoID: Int
    var toDo: String
    
    init(toDoID: Int, toDo: String) {
        self.toDoID = toDoID
        self.toDo = toDo
    }
    
    enum CodingKeys: String, CodingKey {
        case personID = "to_do_id"
        case toDo = "to_do"
    }
}
