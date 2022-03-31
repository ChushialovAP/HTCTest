import Foundation

protocol StudentsListPresenterProtocol {

    var view: StudentsListViewable? { get set }

    var students: [Student] { get set }
    
    func loadStudents()
    
    func addStudent(firstName: String, lastName: String, gpa: String)
    
    func deleteStudent(student: Student)
}
