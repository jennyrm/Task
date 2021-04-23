//
//  TaskController.swift
//  Task
//
//  Created by Jenny Morales on 4/21/21.
//

import Foundation

class TaskController {
    //MARK: - Properties
    static let shared = TaskController()
    
    var tasks = [Task]()
    
    //MARK: - CRUD
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        
        saveToPersistenceStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(task: Task) {
//        task.isComplete = !task.isComplete
        task.isComplete.toggle()
        
        saveToPersistenceStore()
    }
    
    func delete(task: Task) {
        if let index = tasks.firstIndex(where: { $0 == task }) {
            tasks.remove(at: index)
        }
        
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Tasks.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: createPersistenceStore())
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}//End of class
