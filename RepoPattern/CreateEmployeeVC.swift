//
//  ViewController.swift
//  RepoPattern
//
//  Created by Pushpank Kumar on 27/08/20.
//  Copyright © 2020 Pushpank Kumar. All rights reserved.
//

import UIKit

class CreateEmployeeVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var employeeEmailIdTextField: UITextField!
    private let manager: EmployeeManager = EmployeeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint("path", path)
    }
}

// MARK: IBActions
extension CreateEmployeeVC {
    @IBAction func createButtonTapped(_ sender: Any) {
        createEmployeeRecord()
    }
    
    @IBAction func selectImage(_ sender: Any) {
        selectImage()
    }
}

// MARK: UIImagePickerControllerDelegate
extension CreateEmployeeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImageView.image = image
        dismiss(animated: true)
    }
}

// Private Mathods
extension CreateEmployeeVC {
    private func selectImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func createEmployeeRecord() {
        
        guard let emailId = employeeEmailIdTextField.text, let name = employeeNameTextField.text else {
            return
        }
        /// can implement email validation
        let employee = Employee(email: emailId, id: UUID(), name: name, profilePic: profileImageView.image?.pngData())
        manager.createEmployee(employee: employee)
        performSegue(withIdentifier: SegueIdentifier.navigateToEmployeeList, sender: nil)
        
    }
}
