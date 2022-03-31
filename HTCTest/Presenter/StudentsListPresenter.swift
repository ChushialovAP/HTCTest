//
//  StudentsListPresenter.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//

import Foundation
import CoreData

class StudentsListPresenter: StudentsListPresenterProtocol {
    
    // MARK: - Properties
    weak var view: StudentsListViewable?
    
    var model: StudentModelInput
    
    var students: [Student] = []
    
    // MARK: - Core data
    func loadStudents() {
        model.fetchAllStudents(completion: { [weak self] students in
            self?.students = students ?? []
            self?.view?.displayStudents()
        })
    }
    
    func addStudent(firstName: String, lastName: String, gpa: String) {
        model.addStudent(firstName: firstName, lastName: lastName, gpa: gpa)
        
        model.fetchAllStudents { [weak self] students in
            self?.students = students ?? []
            self?.view?.displayStudents()
        }
    }
    
    func deleteStudent(student: Student) {
        model.deleteStudent(student: student)
        
        model.fetchAllStudents { [weak self] students in
            self?.students = students ?? []
            self?.view?.displayStudents()
        }
    }

    // MARK: - Init
    init(view: StudentsListViewable, model: StudentModelInput) {
        self.view = view
        self.model = model
    }

}
