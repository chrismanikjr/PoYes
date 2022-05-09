//
//  AddViewController.swift
//  Poyes
//
//  Created by Chrismanto Natanail Manik on 29/04/22.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var taskTxtfield: UITextField!
    @IBOutlet weak var flagBtn: UIButton!
    @IBOutlet weak var workBtn: UIButton!
    @IBOutlet weak var studyBtn: UIButton!
    @IBOutlet weak var exerciseBtn: UIButton!
    @IBOutlet weak var breakBtn: UIButton!
    @IBOutlet weak var choresBtn: UIButton!
    @IBOutlet weak var mealBtn: UIButton!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var reminderTimeLabel: UILabel!
    @IBOutlet weak var startStackView: UIStackView!
    @IBOutlet weak var endStackView: UIStackView!
    @IBOutlet weak var reminderStackView: UIStackView!
    private var categoryButtons: [UIButton] = []
    
//    private var startDatePicker: UIDatePicker!
//    private var endTimePicker: UIDatePicker!
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var startDatePicker : UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.autoresizingMask = .flexibleWidth
            if #available(iOS 13, *) {
                datePicker.backgroundColor = .label
            } else {
                datePicker.backgroundColor = .white
            }
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels

            return datePicker
        }()
    private lazy var endDatePicker : UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.autoresizingMask = .flexibleWidth
            if #available(iOS 13, *) {
                datePicker.backgroundColor = .label
            } else {
                datePicker.backgroundColor = .white
            }
            datePicker.datePickerMode = .time
            datePicker.preferredDatePickerStyle = .wheels

            return datePicker
        }()
    private lazy var reminderPicker : UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.autoresizingMask = .flexibleWidth
            if #available(iOS 13, *) {
                datePicker.backgroundColor = .label
            } else {
                datePicker.backgroundColor = .white
            }
            datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels

            return datePicker
        }()
    
    var selectedIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stackViewAction()
        setupButton()

        // Do any additional setup after loading the view.
    }
    func stackViewAction(){
        let startTapGesture = UITapGestureRecognizer(target: self, action: #selector(startTapped))
        startStackView.isUserInteractionEnabled = true
        startStackView.addGestureRecognizer(startTapGesture)
        
        let endTapGesture = UITapGestureRecognizer(target: self, action: #selector(endTapped))
        endStackView.isUserInteractionEnabled = true
        endStackView.addGestureRecognizer(endTapGesture)
        
        let reminderTapGesture = UITapGestureRecognizer(target: self, action: #selector(reminderTapped))
        reminderStackView.isUserInteractionEnabled = true
        reminderStackView.addGestureRecognizer(reminderTapGesture)
    }
    
    func setupButton(){
        cancelBtn.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        [workBtn, studyBtn, exerciseBtn, breakBtn, choresBtn, mealBtn].forEach{categoryButtons.append($0)}
        [workBtn, studyBtn, exerciseBtn, breakBtn, choresBtn, mealBtn].forEach{$0?.addTarget(self, action: #selector(categoryTapped(_:)), for: .touchUpInside)}
        [workBtn, studyBtn, exerciseBtn, breakBtn, choresBtn, mealBtn].forEach{$0?.layer.cornerRadius = 5}
        
        radioBtn.isUserInteractionEnabled = false

    }
    //MARK: - Func to Show Calendar
    func tempShow(sender: UIDatePicker){
        let tempInput = UITextField( frame:CGRect.zero )
        tempInput.inputView = sender       // Your picker
        self.view.addSubview( tempInput )
        tempInput.becomeFirstResponder()
    }
    //MARK: - Objc Function
    
    @objc func categoryTapped(_ sender: UIButton){
        print("test")
        var backgroundColor = UIColor.white

        for (buttonIndex, btn) in categoryButtons.enumerated() {
            if btn == sender {
                selectedIndex = buttonIndex
                switch selectedIndex{
                case 0:
                    backgroundColor = UIColor(named: K.Color.Tag.work)!
                case 1:
                    backgroundColor = UIColor(named: K.Color.Tag.study)!
                case 2:
                    backgroundColor = UIColor(named: K.Color.Tag.exercise)!
                case 3:
                    backgroundColor = UIColor(named: K.Color.Tag.rest)!
                case 4:
                    backgroundColor = UIColor(named: K.Color.Tag.chrores)!
                case 5:
                    backgroundColor = UIColor(named: K.Color.Tag.meal)!
                default:
                    backgroundColor = .white
                }
                UIView.animate(withDuration: 0.3) {
                    btn.setTitleColor(.white, for: .normal)
                    btn.backgroundColor = backgroundColor
                }
            }else{
                
                btn.setTitleColor(.black, for: .normal)
//                btn.layer.borderColor = UIColor.clear.cgColor
                btn.backgroundColor = .clear
            }

        }
    }
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func startTapped(){
        startDatePicker = UIDatePicker()
        view.addSubview(startDatePicker)
        startDatePicker.addTarget(self, action: #selector(startDateDidChange(_:)), for: .valueChanged)
        tempShow(sender: startDatePicker)
    }
    @objc func endTapped(){
        endDatePicker = UIDatePicker()
        view.addSubview(endDatePicker)
        endDatePicker.addTarget(self, action: #selector(endDateDidChange(_:)), for: .valueChanged)
        tempShow(sender: endDatePicker)
    }
    @objc func reminderTapped(){
        reminderPicker = UIDatePicker()
        view.addSubview(reminderPicker)
        reminderPicker.addTarget(self, action: #selector(reminderDidChange(_:)), for: .valueChanged)
        tempShow(sender: reminderPicker)
    }
    
    
    @objc func startDateDidChange(_ sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy - h:mm a"
        startDateLabel.text = dateFormatter.string(from: sender.date)
//        startDatePicker.removeFromSuperview()
    }
    @objc func endDateDidChange(_ sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        endTimeLabel.text = dateFormatter.string(from: sender.date)
//        startDatePicker.removeFromSuperview()
    }
    @objc func reminderDidChange(_ sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy - h:mm a"
        reminderTimeLabel.text = dateFormatter.string(from: sender.date)
//        startDatePicker.removeFromSuperview()
    }
    

}
