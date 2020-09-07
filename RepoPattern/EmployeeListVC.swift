//
//  EmployeeListVC.swift
//  RepoPattern
//
//  Created by Pushpank Kumar on 01/09/20.
//  Copyright © 2020 Pushpank Kumar. All rights reserved.
//

import UIKit

class EmployeeListVC: UIViewController {
    
    @IBOutlet weak var employeeTableView: UITableView!
    var employees : [Employee]? = nil
    private let manager = EmployeeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Employees List"
        employees = manager.fetchEmployee()
        if employees != nil && employees?.count != 0 {
            employeeTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == SegueIdentifier.navigateToEmployeeDetailView) {
            let detailsView = segue.destination as? DetailVC
            guard detailsView != nil else { return }
            detailsView?.selectedEmployee = self.employees![self.employeeTableView.indexPathForSelectedRow!.row]
        }
    }
}

extension EmployeeListVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.employees!.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! EmployeeListCell
        let employee = self.employees![indexPath.row]
       
        cell.employeeNameLabel.text = employee.name
        cell.profileImageView.image = UIImage(data: employee.profilePic!)

        return cell
    }
}
