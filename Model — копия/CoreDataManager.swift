
import Foundation
import CoreData
import UIKit

 protocol ICoreDataManager
{
    func createNewStudent(with name: String, university: University)
    func createNewUniversity(with name: String)
    func fetchAllStudents() -> Result <[Student2], Error>
    func fetchAllUniversity() -> Result <[University], Error>
    func fetchUniversity(id: UUID) -> Result<University, Error>
    func fetchStudent(id: UUID) -> Result<Student2, Error>
    func link(studentId: UUID, universityId: UUID) -> Result<Void, Error>
    func clear() -> Result<Void, Error>
    func deleteStudent(number: UUID) -> Result<Void, Error>
    func deleteUniversity(number: UUID) -> Result<Void, Error>
    func saveContext() -> Result<Void, Error>
}

final class CoreDataManager : ICoreDataManager
{
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               fatalError("COreData error!&!&!& \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
     var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // Функция для сохранения в базу данных
    func createNewStudent(with name: String, university: University) {
        let model = Student2(context: self.context )
        model.name = name
        model.id = UUID()
        model.university = university
        self.saveContext()
    }
    
    func createNewUniversity(with name: String){
        let model = University(context: self.context )
        model.name = name
        model.id = UUID()
        self.saveContext()
    }
    
   //Функция запроса в б/д
    func fetchAllStudents() -> Result <[Student2], Error> {
        let request = NSFetchRequest<Student2>(entityName: "Student2")
        do {
            let result = try self.context.fetch(request)
            return.success(result)
        } catch {
            return.failure(error)
        }
    }
    
    func fetchAllUniversity() -> Result <[University], Error> {
        let request = NSFetchRequest<University>(entityName: "University")
        do {
            let result = try self.context.fetch(request)
            return.success(result)
        } catch {
            return.failure(error)
        }
    }
    
    func fetchUniversity(id: UUID) -> Result<University, Error> {
        let result = self.fetchAllUniversity()
        switch result {
        case .success(let university):
            guard let university = university.first(where: { $0.id == id }) else {return .failure(NSError()) }
            return .success(university)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchStudent(id: UUID) -> Result<Student2, Error> {
        let result = self.fetchAllStudents()
        switch result {
        case .success(let students):
            guard let students = students.first(where: { $0.id == id }) else {return .failure(NSError()) }
            return .success(students)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    //Функция связи студентов
    func link(studentId: UUID, universityId: UUID) -> Result<Void, Error> {
        guard case .success(let student) = self.fetchStudent(id: studentId),
              case .success(let university) = self.fetchUniversity(id: universityId) else { return .failure(NSError())}
        student.university = university
        return self.saveContext()
    }
    
    //Функция очистки
    func clear() -> Result<Void, Error> {
        let result = fetchAllStudents()
        switch result {
        case .success(let students):
            students.forEach { self.context.delete($0)}
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteStudent(number: UUID) -> Result<Void, Error> {
        let result = fetchAllStudents()
        switch result {
        case .success(let students):
            students.filter { $0.id == number }.forEach { self.context.delete($0) }
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteUniversity(number: UUID) -> Result<Void, Error> {
        let result = fetchAllUniversity()
        switch result {
        case .success(let university):
            university.filter { $0.id == number }.forEach { self.context.delete($0) }
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
}


 extension CoreDataManager {
    func saveContext() -> Result<Void, Error> {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return .success
            } catch {
                return .failure(error)
            }
        }
        return .success
    }
}
