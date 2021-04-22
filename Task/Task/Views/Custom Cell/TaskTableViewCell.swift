//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Jenny Morales on 4/21/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    //MARK: - Lifecycle
    
    //MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?
    
    //MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        delegate?.taskCellButtonTapped(self)
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        let completeImage = UIImage(named: "complete")
        let incompleteImage = UIImage(named: "incomplete")
        task.isComplete ? completionButton.setImage(completeImage, for: .normal) : completionButton.setImage(incompleteImage, for: .normal)
    }
}//End of class
