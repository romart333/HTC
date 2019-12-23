//
//  StudentViewController.swift
//  HTC Internship
//
//  Created by Roman on 20/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    private let averageMarkRange = (2.0...5.0)
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSecondName: UITextField!
    @IBOutlet weak var textFieldAverageMark: UITextField!
    
    var student: Student?
    
    @IBAction func pushSaveAction(_ sender: Any) {
        
        let name = textFieldName.text ?? ""
        let secondName = textFieldSecondName.text ?? ""
        var errorMessage = ""
        if !(name.containsOnlyLetters() && secondName.containsOnlyLetters()) {
            errorMessage += "Имя и фамилия должны содержать только буквы\n"
        }
        
        var averageMark = 0.0
        if let averageMarkString = textFieldAverageMark?.text {
            averageMark = Double(averageMarkString) ?? 0
        }
        
        if (!averageMarkRange.contains(averageMark)) {
            errorMessage += "Средний балл должен быть в дипазоне от 2 до 5\n"
        }
        
        if !errorMessage.isEmpty {
            errorMessage += "Поля не могут быть пустыми"
            let alert = UIAlertController(title: "Неверный ввод",
                                           message: errorMessage,
                                           preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }
        
        if let student = student {
            student.name = name
            student.secondName = secondName
            student.averageMark = averageMark
        } else {
            let newStudent = Student(name: name, secondName:secondName, averageMark: averageMark)
            StudentStorage.shared.addStudent(student: newStudent)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = student {
            textFieldName.text = student.name
            textFieldSecondName.text = student.secondName
            textFieldAverageMark.text = String(student.averageMark)
        }
    }

}
