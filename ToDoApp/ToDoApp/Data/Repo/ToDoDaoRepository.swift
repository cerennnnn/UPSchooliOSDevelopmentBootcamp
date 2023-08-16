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
    let db: FMDatabase?
    
    init() {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: filePath).appendingPathComponent("ToDoListDB.sqlite")
        
        db = FMDatabase(path: databaseURL.path)
    }
    
    func saveToDo(toDo: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO ToDoList (toDo) VALUES (?)", values: [toDo])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func updateToDo(toDoID: Int, toDo: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE ToDoList SET toDo = ? WHERE toDoID = ? ", values: [toDo, toDoID])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func loadAllToDos() {
        
        db?.open()
        var toDos = [ToDo]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM ToDoList", values: nil)
            
            while result.next() {
                let toDoID = Int(result.string(forColumn: "toDoID"))!
                let toDoItem = result.string(forColumn: "toDo")!
                
                let toDo = ToDo(toDoID: toDoID, toDo: toDoItem)
                toDos.append(toDo)
            }
            toDoList.onNext(toDos)
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func deleteAllTodos() {
        db?.open()
        
        db!.executeUpdate("DELETE from ToDoList", withArgumentsIn: nil)
        
        db?.close()
    }
    
    func deleteToDo(toDoID: Int) {
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE from ToDoList WHERE toDoID = ?", values: [toDoID])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func search(toDo: String) {
        db?.open()
        
        var toDos = [ToDo]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM ToDoList WHERE toDo like '%\(toDo)%'", values: nil)
            
            while result.next() {
                
                let toDoID = Int(result.string(forColumn: "toDoID"))!
                let toDoItem = result.string(forColumn: "toDo")!
                
                let toDo = ToDo(toDoID: toDoID, toDo: toDoItem)
                toDos.append(toDo)
            }
            
            toDoList.onNext(toDos)
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
