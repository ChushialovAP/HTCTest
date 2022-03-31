//
//  NewStudentViewable.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//

import Foundation

protocol NewStudentViewable: AnyObject {
    
    func showError(error: String)
    
    func addStudent(firstName: String, lastName: String, gpa: String)
}
