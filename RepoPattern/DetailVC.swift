//
//  DetailVC.swift
//  RepoPattern
//
//  Created by Pushpank Kumar on 02/09/20.
//  Copyright © 2020 Pushpank Kumar. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    
    private let manager = EmployeeManager()
    var selectedEmployee: Employee? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetUp()
        // Do any additional setup after loading the view.
    }
    
    func viewWillSetUp() {
          self.employeeNameTextField.text = selectedEmployee?.name
          self.emailIdTextField.text = selectedEmployee?.email
          self.profileImageView.image = UIImage(data: (selectedEmployee?.profilePic)!)
      }
    
    // MARK: Update button action
     @IBAction func updateButtonTapped(_ sender: Any) {

        let employee = Employee(email: emailIdTextField.text, id: selectedEmployee?.id!, name: employeeNameTextField.text!, profilePic: self.profileImageView.image?.pngData())


         if(manager.updateEmployee(employee: employee))
         {
            displayAlert(alertMessage: "Record Updated")
         }else
         {
             displayErrorAlert()
         }

     }
    
    // MARK: Delete button action
     @IBAction func deleteButtonTapped(_ sender: Any) {
        
        if manager.deleteEmployee(id: selectedEmployee?.id! ?? UUID()) {
            displayAlert(alertMessage: "Record deleted")
        } else {
            displayErrorAlert()
        }

     }
    
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: Private functions
    private func displayAlert(alertMessage:String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func displayErrorAlert()
     {
         let errorAlert = UIAlertController(title: "Alert", message: "Something went wrong, please try again later", preferredStyle: .alert)

         let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
         errorAlert.addAction(okAction)
         self.present(errorAlert, animated: true)
     }
}



extension DetailVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as? UIImage
        self.profileImageView.image = img
        dismiss(animated: true, completion: nil)
    }
}
