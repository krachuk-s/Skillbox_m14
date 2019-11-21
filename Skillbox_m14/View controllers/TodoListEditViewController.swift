//
//  TodoListEditViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 08.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class TodoListEditViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    var name: String = ""
    var color: UIColor = .systemGreen {
        didSet {
            colorView?.backgroundColor = color
        }
    }
    
    let colors: [UIColor] = [
        .systemGreen,
        .systemRed,
        .systemBlue
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
    
    func updateUI() {
        
        nameTextField.text = name
        colorView.backgroundColor = color
        updateDoneButton()
    }
    
    func updateDoneButton() {
        doneButton.isEnabled = !name.isEmpty
    }
    
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        
        name = nameTextField.text ?? "" 
        updateDoneButton()
    }
    
}


extension TodoListEditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
}

extension TodoListEditViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return colors.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        
        cell.color = colors[indexPath.item]
        
        return cell
        
    }
    
}

extension TodoListEditViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        color = colors[indexPath.item]
        
    }
    
}
