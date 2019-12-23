//
//  Student.swift
//  HTC Internship
//
//  Created by Roman on 20/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

struct StudentStorage {
    
    static var shared: StudentStorage = {
        let instance = StudentStorage()
        return instance
    }()
    
    private init() {
        students = [Student]()
    }
    
    private var students: [Student]
    
    func getCountOfStudents() -> Int {
        return students.count
    }
    
    func getStudentWith(index: Int) -> Student? {
        if ((0..<students.count).contains(index)) {
            return students[index]
        } else {
            return nil
        }
    }
    
    mutating func addStudent(student: Student) {
        students.append(student)
    }
    
    mutating func deleteStudentWith(index: Int) {
        if ((0..<students.count).contains(index)) {
            students.remove(at: 0)
        }
    }
    
    func saveStudents() throws {
        let studentData = try JSONEncoder().encode(students)
        UserDefaults.standard.set(studentData, forKey: "studentArray")
    }
    
    mutating func loadStudents() throws {
        guard let studentData = UserDefaults.standard.data(forKey: "studentArray") else {
            print("No one student was loaded")
            return
        }
        students = try JSONDecoder().decode([Student].self, from: studentData)
    }
}

class Student: Codable {
    
    init(name: String, secondName: String, averageMark: Double) {
        self.name = name
        self.secondName = secondName
        self.averageMark = averageMark
    }
    
    var name: String
    
    var secondName: String
    
    var fullName: String {
        get {
            return "\(name) \(secondName)"
        }
    }
    
    var averageMark: Double
}
