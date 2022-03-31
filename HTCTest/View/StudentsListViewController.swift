//
//  StudentsListViewController.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//

import UIKit

class StudentsListViewController: UIViewController, StudentsListViewable, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    private var studentsListPresenter: StudentsListPresenterProtocol!
    
    var coreDataStack: CoreDataStack!
    
    // MARK: - IBOutlets
    @IBOutlet weak var studentsListTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        coreDataStack = CoreDataStack()
        let model = StudentModel(moContext: coreDataStack.moContext)
        studentsListPresenter = StudentsListPresenter(view: self, model: model)
        
        studentsListTableView.delegate = self
        studentsListTableView.dataSource = self
        
        self.studentsListPresenter.loadStudents()
    }

    // MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let newStudentVC = storyboard.instantiateViewController(
                identifier: Constants.VCIdentifiers.newStudentVC
            ) as? NewStudentViewController
        else {
            fatalError()
        }
        newStudentVC.delegate = self
        
        self.navigationController?.pushViewController(newStudentVC, animated: true)
    }
    
    // MARK: - Methods
        func displayStudents() {
            DispatchQueue.main.async {
                self.studentsListTableView.reloadData()
            }
        }

    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentsListPresenter.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.StudentInfoCell.reuseIdentifier,
            for: indexPath
        ) as? StudentsListTableViewCell

        cell?.configureCell(student: self.studentsListPresenter.students[indexPath.row])

        return cell ?? UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.StudentInfoCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let newStudentVC = storyboard.instantiateViewController(
                identifier: Constants.VCIdentifiers.newStudentVC
            ) as? NewStudentViewController
        else {
            fatalError()
        }
        newStudentVC.delegate = self
        newStudentVC.student = studentsListPresenter.students[indexPath.row]
        
        self.navigationController?.pushViewController(newStudentVC, animated: true)
    }
    
    // swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studentsListPresenter.deleteStudent(student: studentsListPresenter.students[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension StudentsListViewController: AddStudentDelegate {
    
    func addStudent(firstName: String, lastName: String, gpa: String) {
        navigationController?.popViewController(animated: true)
        studentsListPresenter.addStudent(firstName: firstName, lastName: lastName, gpa: gpa)
    }
}
