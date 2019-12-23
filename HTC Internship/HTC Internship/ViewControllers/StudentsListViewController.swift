//
//  ViewController.swift
//  HTC Internship
//
//  Created by Roman on 20/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class StudentsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func pushAddAction(_ sender: Any) {
        performSegue(withIdentifier: "goToStudent", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try StudentStorage.shared.loadStudents()
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentStorage.shared.getCountOfStudents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let student = StudentStorage.shared.getStudentWith(index: indexPath.row) {
            cell.textLabel?.text = student.fullName
            cell.detailTextLabel?.text = String(student.averageMark)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StudentStorage.shared.deleteStudentWith(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToStudent", sender: indexPath.row)
    }
   
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStudent" {
            guard let vc = segue.destination as? StudentViewController else {
                return
            }
            
            let index = sender as? Int
            if let index = index {
                 vc.student = StudentStorage.shared.getStudentWith(index: index)
            }
        }
     }
}
