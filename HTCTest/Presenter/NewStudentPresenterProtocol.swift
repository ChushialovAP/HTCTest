//
//  NewStudentPresenterProtocol.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//

import Foundation

protocol NewStudentPresenterProtocol {
    
    var view: NewStudentViewable? { get set }
    
    func addStudent(firstName: String, lastName: String, gpa: String)
}
