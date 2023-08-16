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
        copyDatabase()
        self.toDoList = toDoRepo.toDoList
    }
    
    func loadAllToDos() {
        toDoRepo.loadAllToDos()
    }
    
    func deleteToDo(toDoID: Int) {
        toDoRepo.deleteToDo(toDoID: toDoID)
        loadAllToDos()
    }
    
    func deleteAllToDos() {
        toDoRepo.deleteAllTodos()
    }
    
    func search(toDo: String) {
        toDoRepo.search(toDo: toDo)
    }
    
    func copyDatabase() {
        let bundlePath = Bundle.main.path(forResource: "ToDoListDB", ofType: ".sqlite")
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: filePath).appendingPathComponent("ToDoListDB.sqlite")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath: databaseURL.path()) {
            print("Database exists.")
        } else {
            do {
                try fm.copyItem(atPath: bundlePath!, toPath: databaseURL.path())
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
