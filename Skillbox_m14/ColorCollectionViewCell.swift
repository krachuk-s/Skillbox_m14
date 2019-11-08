//
//  ColorCollectionViewCell.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 08.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    override var frame: CGRect {
        didSet {
            colorView?.layer.cornerRadius = colorView.frame.width / 2
        }
    }
    
    var color: UIColor = .black {
        didSet {
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
    
    func updateUI() {
        colorView.backgroundColor = color
    }
}
