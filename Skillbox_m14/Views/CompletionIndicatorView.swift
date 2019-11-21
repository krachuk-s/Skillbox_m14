//
//  CompletionIndicatorView.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 09.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

@IBDesignable class CompletionIndicatorView: UIView {

    private var innerView: UIView = UIView()
    private var middleView: UIView = UIView()
    private var isSetuped = false
    
    weak var delegate: CompletionIndicatorViewDelegate?
    
    @IBInspectable var isCompleted: Bool = false { didSet { setNeedsLayout() } }
    @IBInspectable var color: UIColor = .systemRed { didSet { setNeedsLayout() } }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isSetuped {
            initialSetup()
            isSetuped = true
        }
        
        innerView.frame = bounds.insetBy(dx: 4.0, dy: 4.0)
        middleView.frame = bounds.insetBy(dx: 2.0, dy: 2.0)
        
        layer.cornerRadius = frame.width / 2
        innerView.layer.cornerRadius = innerView.frame.width / 2
        middleView.layer.cornerRadius = middleView.frame.width / 2
        
        if isCompleted {
            backgroundColor = color
            innerView.isHidden = false
        } else {
            backgroundColor = .systemGray
            innerView.isHidden = true
        }
        
        
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        isCompleted.toggle()
        delegate?.completionIndicatorDidChangedValue(self)
    }
    
    private func initialSetup() {
        
        middleView.backgroundColor = UIColor.systemBackground
        addSubview(middleView)
        
        innerView.backgroundColor = color
        addSubview(innerView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(tap)
        
    }

}

protocol CompletionIndicatorViewDelegate: class {
    func completionIndicatorDidChangedValue(_ indicator: CompletionIndicatorView)
}
