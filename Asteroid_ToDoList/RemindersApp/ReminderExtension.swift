//
//  TaskItemExtension.swift
//  TodoListAppTutorial
//
//  Created by Callum Hill on 31/7/2022.
//

import SwiftUI

extension Reminder
{
    
    func isOverdue() -> Bool
    {
        if let due = reminderDate
        {
            return !isCompleted && (reminderTime != nil) && due < Date()
        }
        return false
    }
    
    func overDueColor() -> Color
    {
        return isOverdue() ? .red : .black
    }
    
    
    func dueDateTimeOnly() -> String
    {
        if let due = reminderDate
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        
        return ""
    }
}
