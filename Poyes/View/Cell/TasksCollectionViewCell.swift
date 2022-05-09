//
//  TasksCollectionViewCell.swift
//  Poyes
//
//  Created by Chrismanto Natanail Manik on 28/04/22.
//

import UIKit

class TasksCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "taskCell"
    var unCheckImage = UIImage(systemName: "circle")!.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray)
    var checkedImage = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.green)
    
    var isDone: Bool = false
    private lazy var radioCheck: UIButton = {
        let btn = UIButton()
        btn.setImage(unCheckImage, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.addTarget(self, action: #selector(checkDoneTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var taskLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lbl.textColor = .black
        lbl.numberOfLines = 1
        return lbl
    }()
    private lazy var rangeTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.italicSystemFont(ofSize: 15, weight: .regular)
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        return lbl
    }()
    
   
    private lazy var leftStackView: UIStackView = {
        let stack = UIStackView()
        Utils.styleStackVer(stack, aligment: .fill, distribution: .fill, spacing: 2)
        return stack
    }()
    
    private lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lbl.textAlignment = .right
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
   
    private lazy var doubleTaskImg: UIImageView = {
        let imgView = UIImageView()
        guard let highColor = UIColor(named: "HighPriorityColor") else {fatalError()}
        imgView.image = UIImage(systemName: "exclamationmark.circle.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(highColor)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        imgView.isHidden = true
        return imgView
    }()
    
    private var topRightStack: UIStackView = {
        let stack = UIStackView()
        Utils.styleStackHori(stack, aligment: .fill, distribution: .fill, spacing: 2)
        return stack
    }()
    private lazy var alarmImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "alarm.fill")!.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        imgView.isHidden = false
        return imgView
    }()
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        Utils.styleStackVer(stack, aligment: .trailing, distribution: .fill, spacing: 4)
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        Utils.styleStackHori(stack, aligment: .center, distribution: .fill, spacing: 5)
        
        return stack
    }()
    
    private lazy var tagView: UIView = {
        let vw = UIView()
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 2
        vw.backgroundColor = UIColor(named: "ExerciseTagColor")
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.widthAnchor.constraint(equalToConstant: 5).isActive = true
        return vw
    }()
    
    private lazy var containerView : UIView = {
        let vw = UIView()
        vw.backgroundColor = .white
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 4
        return vw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(task: TaskModel){
        taskLabel.text = task.taskName
        rangeTimeLabel.text = task.range
        timeLabel.text = task.time
        if task.reminder != nil{
            alarmImageView.isHidden = false
        }
        isDone = task.isDone
        statusTask(with: isDone)
        setupUi()
    }
    
    //MARK: - Objc Function
    @objc func checkDoneTapped(){
        isDone = !isDone
        statusTask(with: isDone)
        
    }
    func statusTask(with condition: Bool){
        radioCheck.setImage(isDone ? checkedImage : unCheckImage, for: .normal)
        guard let text = taskLabel.text else{return}
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [.foregroundColor: UIColor.lightGray])
        if isDone{
            attributeString.addAttribute(.strikethroughStyle ,value: 1, range: NSRange(location: 0, length:attributeString.length))
            taskLabel.attributedText = attributeString
        }else{
            attributeString.setAttributes([:], range: NSRange(location: 0, length:attributeString.length))
            taskLabel.attributedText = attributeString
        }
    }
    func setupUi(){
        self.addSubview(containerView)
        
        [taskLabel, rangeTimeLabel].forEach{leftStackView.addArrangedSubview($0)}
        [doubleTaskImg, timeLabel].forEach{topRightStack.addArrangedSubview($0)}
        [topRightStack, alarmImageView].forEach{rightStack.addArrangedSubview($0)}
        
        [leftStackView, rightStack].forEach{stackView.addArrangedSubview($0)}
        
        
        [radioCheck, stackView, tagView].forEach{containerView.addSubview($0)}
        
//        rightStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 20
        let padTag: CGFloat = 2.5
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            radioCheck.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            radioCheck.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
//            rightStack.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.leadingAnchor.constraint(equalTo: radioCheck.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
//            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            tagView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tagView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padTag),
            tagView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padTag),
        ])
    }
}
