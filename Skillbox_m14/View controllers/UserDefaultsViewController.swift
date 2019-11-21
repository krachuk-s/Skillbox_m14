//
//  ViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 31.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class UserDefaultsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    
    var user: UserData! {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = UserData.current ?? UserData(name: "", familyName: "")
        
        nameTextField.delegate = self
        familyTextField.delegate = self
    }

    func saveUser() {
        UserData.current = user
    }
    
    func updateUI() {
        nameTextField.text = user?.name
        familyTextField.text = user?.familyName
    }
    
    @IBAction func nameTextFieldDidEndEditing(_ sender: UITextField) {
        user.name = nameTextField.text!
        saveUser()
    }
    
    @IBAction func familyNameTextFieldDidEndEditing(_ sender: UITextField) {
        user.familyName = familyTextField.text!
        saveUser()
    }
    
}

extension UserDefaultsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

