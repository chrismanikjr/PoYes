//
//  K.swift
//  Poyes
//
//  Created by Chrismanto Natanail Manik on 08/05/22.
//

import Foundation

struct K{
    struct Color{
        static let done = "DoneColor"
        static let dateLight = "DateLightColor"
        static let dateCircle = "DateCircleColor"
        static let poyes = "PoyesColor"
        
        struct Priority{
            static let none = "NonePriorityColor"
            static let low = "LowPriorityColor"
            static let medium = "MediumPriorityColor"
            static let high = "HighPriorityColor"
        }
        struct Tag{
            static let rest = "BreakColor"
            static let chrores = "ChoresTagColor"
            static let exercise = "ExerciseTagColor"
            static let meal = "MealTagColor"
            static let study = "StudyTagColor"
            static let work = "WorkTagColor"
        }
    }
}
