//
//  Utils.swift
//  Poyes
//
//  Created by Chrismanto Natanail Manik on 28/04/22.
//

import Foundation
import UIKit
class Utils{
//    enum CategoryColor: UIColor{
//        case work = "Work"
//        case study = "Study"
//        case exercise = "Exercise"
//        case rest = "Break"
//        case chrores = "Chores"
//        case meal = "Meal"
//    }
    //MARK: - Custom StackView
    static func styleStackHori(_ sender: UIStackView, aligment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat){
        sender.axis = .horizontal
        sender.alignment = aligment
        sender.distribution = distribution
        sender.spacing = spacing
    }

    static func styleStackVer(_ sender: UIStackView, aligment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat){
        sender.axis = .vertical
        sender.alignment = aligment
        sender.distribution = distribution
        sender.spacing = spacing
    }
}
