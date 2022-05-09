//
//  TaskModel.swift
//  Poyes
//
//  Created by Chrismanto Natanail Manik on 28/04/22.
//

import Foundation

enum Priority: String{
    case high = "High Priority"
    case medium = "Medium Priority"
    case low = "Low Priority"
    case non = "No Priority"
}
enum Tag: String{
    case work = "Work"
    case study = "Study"
    case exercise = "Exercise"
    case rest = "Break"
    case chrores = "Chores"
    case meal = "Meal"
}

struct TaskModel:Hashable{
    var taskName: String
    var range: String?
    var time: String
    var priority: Priority
    var reminder: String?
    var isDone: Bool
}
