//
//  StudentsListTableViewCell.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//

import UIKit

class StudentsListTableViewCell: UITableViewCell {

   // MARK: - IBOutlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
    // MARK: - Methods
    func configureCell(student: Student) {
        
        self.firstNameLabel.text = student.firstName
        self.lastNameLabel.text = student.lastName
        self.gpaLabel.text = student.gpa
    }
}
