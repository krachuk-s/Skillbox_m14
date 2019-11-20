//
//  TodoItemTableViewCell.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 09.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var completionIndicator: CompletionIndicatorView!
    @IBOutlet weak var todoTextView: UITextView!
    
    var isCompleted: Bool {
        get {
            completionIndicator.isCompleted
        }
        set {
            completionIndicator.isCompleted = newValue
        }
    }
    
    weak var delegate: TodoItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        todoTextView.delegate = self
        completionIndicator.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        completionIndicator.layer.cornerRadius = completionIndicator.frame.width / 2
    }
    
    
}

extension TodoItemTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.todoItemTableViewCellDidBeginEditing(self)
    }
    func textViewDidChange(_ textView: UITextView) {
        delegate?.todoItemTableViewCellDidChange(self)
    }
}

extension TodoItemTableViewCell: CompletionIndicatorViewDelegate {
    func completionIndicatorDidChangedValue(_ indicator: CompletionIndicatorView) {
        delegate?.todoItemTableViewCellDidChange(self, isCompleted: completionIndicator.isCompleted)
    }
}

protocol TodoItemTableViewCellDelegate: class {
    func todoItemTableViewCellDidBeginEditing(_ cell: TodoItemTableViewCell)
    func todoItemTableViewCellDidChange(_ cell: TodoItemTableViewCell)
    func todoItemTableViewCellDidChange(_ cell: TodoItemTableViewCell, isCompleted: Bool)
}
