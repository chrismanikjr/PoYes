//
//  ViewController.swift
//  Poyes
//
//  Created by Chrismanto Natanail Manik on 27/04/22.
//

import UIKit

class TimeLineViewController: UIViewController {

    private enum Section: String, CaseIterable{
        case task = "Task List"
    }
    @IBOutlet weak var weekCollectionView: UICollectionView!
    
    private var taskCollectionView: UICollectionView! = nil
    private var taskDataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>! = nil

    private var dummyData = [TaskModel(taskName: "Wake Up, Wake Up", range: nil, time: "7.30 AM", priority: .high, reminder: "07.00 AM", isDone: false), TaskModel(taskName: "Sleep", range: nil, time: "11.30 PM", priority: .high, reminder: "11.00", isDone: true)]
    override func viewDidLoad() {
        super.viewDidLoad()
        dummyData.insert(TaskModel(taskName: "Take a bath, Take a bath Take a bath Take a bath , Take a bath Take a bath , Take a bath", range: "30 minutes", time: "7.30 AM", priority: .medium, reminder: nil, isDone: false), at: dummyData.count - 1)
        
        setupUi()
        configureDataSource()
        
        
        // Do any additional setup after loading the view.
    }
//    @IBAction func addTapped(_ sender: UIBarButtonItem) {
//        let addVc = AddViewController()
//        addVc.modalPresentationStyle = .fullScreen
//        addVc.modalTransitionStyle = .crossDissolve
//
//        present(addVc, animated: true)
//    }
    
    func setupUi(){
        configureCollection()
        
        taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskCollectionView.topAnchor.constraint(equalTo: weekCollectionView.bottomAnchor, constant: 20),
            taskCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func configureCollection(){
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.register(TasksCollectionViewCell.self, forCellWithReuseIdentifier: TasksCollectionViewCell.identifier)
        taskCollectionView = collectionView
    }

    func generateLayout() -> UICollectionViewLayout{
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(70)
        )
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1)
        )
        let layout = UICollectionViewCompositionalLayout { (sectionNumber: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: groupSize)
            item.contentInsets.bottom = 10.0
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 10
            return section
        }
        return layout
    }
    
    func configureDataSource(){
        taskDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: taskCollectionView){ (collectionView: UICollectionView, indexPath: IndexPath, shopItem: AnyHashable) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TasksCollectionViewCell.identifier, for: indexPath) as? TasksCollectionViewCell else{
                fatalError("Could not create Task Cell")
            }
            cell.configure(task: self.dummyData[indexPath.row])
            return cell
        }
        var taskSnapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        taskSnapshot.appendSections([.task])
        taskSnapshot.appendItems(dummyData, toSection: .task)
        taskDataSource.apply(taskSnapshot, animatingDifferences: false)
    }
}

extension TimeLineViewController: UICollectionViewDelegate{
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { context in
            self.taskCollectionView.collectionViewLayout.invalidateLayout()
        }
    }

}
