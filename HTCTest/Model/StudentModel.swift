import Foundation
import CoreData

protocol StudentModelInput {
    
    func fetchAllStudents(completion: @escaping ([Student]?) -> ())
    
    func addStudent(firstName: String, lastName: String, gpa: String)
    
    func deleteStudent(student: Student)
}

final class StudentModel: StudentModelInput {
    
    // MARK: - Properties
    private let moContext: NSManagedObjectContext

    // MARK: - Init
    init(moContext: NSManagedObjectContext) {
        self.moContext = moContext
    }

    // MARK: - Methods
    func fetchAllStudents(completion: @escaping ([Student]?) -> ()) {
        let request = NSFetchRequest<Student>(entityName: "Student")

        if let products = try? moContext.fetch(request) {
            completion(products)
        } else {
            completion(nil)
        }
    }

    func addStudent(firstName: String, lastName: String, gpa: String) {
        let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: moContext) as! Student
        student.firstName = firstName
        student.lastName = lastName
        student.gpa = gpa

        if moContext.hasChanges {
            do {
                try moContext.save()
            } catch let error as NSError {
                print("Core Data Error: \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteStudent(student: Student) {
        moContext.delete(student)
        
        if moContext.hasChanges {
            do {
                try moContext.save()
            } catch let error as NSError {
                print("Core Data Error: \(error), \(error.userInfo)")
            }
        }
    }
}
