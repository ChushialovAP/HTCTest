//
//  NewStudentViewController.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//

import UIKit

// MARK: - AddStudentDelegate
protocol AddStudentDelegate {
    
    func addStudent(firstName: String, lastName: String, gpa: String)
}

class NewStudentViewController: UIViewController, NewStudentViewable {
    
    // MARK: - Properties
    private var newStudentPresenter: NewStudentPresenterProtocol!
    
    var delegate: AddStudentDelegate?
    
    var student: Student?

    // MARK: - IBOutlets
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var gpaTF: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        newStudentPresenter = NewStudentPresenter(view: self)
        
        configureTextFields()
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonPressed(_ sender: Any) {
        newStudentPresenter.addStudent(
            firstName: firstNameTF.text ?? "",
            lastName: lastNameTF.text ?? "",
            gpa: gpaTF.text ?? ""
        )
    }
    
    // why do we even need this button? :|
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    func showError(error: String) {
        let alert = UIAlertController(title: "Failed to add user", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        firstNameTF.text = ""
        lastNameTF.text = ""
        gpaTF.text = ""
    }
    
    func addStudent(firstName: String, lastName: String, gpa: String) {
        delegate?.addStudent(firstName: firstName, lastName: lastName, gpa: gpa)
    }
    
    private func configureTextFields() {
        if let student = student {
            firstNameTF.text = student.firstName
            lastNameTF.text = student.lastName
            gpaTF.text = student.gpa
        }
    }
}

