//
//  NewStudentPresenter.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//

import Foundation
import CoreData

class NewStudentPresenter: NewStudentPresenterProtocol {
    // MARK: - Properties
    weak var view: NewStudentViewable?
    
    // MARK: - Init
    init(view: NewStudentViewable) {
        self.view = view
    }
    
    // MARK: - Methods
    func addStudent(firstName: String, lastName: String, gpa: String) {
        guard isValidName(name: firstName),
              isValidName(name: lastName)
        else {
            self.view?.showError(error: "first name or last name is in incorrect format")
            return
        }
        
        guard let gpaInt = Int(gpa),
              gpaIsInRange(range: 1...5, gpa: gpaInt)
        else {
            self.view?.showError(error: "gpa must be in range from 1 to 5")
            return
        }
                
        self.view?.addStudent(firstName: firstName, lastName: lastName, gpa: gpa)
    }
    
    // validate if gpa is in the range
    private func gpaIsInRange(range: ClosedRange<Int>, gpa: Int) -> Bool {
        return range ~= gpa
    }
    // validate if name is in the right format
    private func isValidName(name: String) -> Bool {
        print(name)
        let regEx = "[A-Za-z\\u0400-\\u04FF]{2,}"

        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: name)
    }

}
