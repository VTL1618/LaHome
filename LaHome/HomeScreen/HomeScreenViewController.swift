//
//  ViewController.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import UIKit

class HomeScreenViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var scenariosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScrollView()
        setupScenariosCollectionView()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .lightGray
        contentView.backgroundColor = .green
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupScenariosCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        scenariosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        scenariosCollectionView.backgroundColor = .cyan
        scenariosCollectionView.showsHorizontalScrollIndicator = false
        scenariosCollectionView.isScrollEnabled = true
        scenariosCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        scenariosCollectionView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(scenariosCollectionView)
        
        scenariosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scenariosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        scenariosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        scenariosCollectionView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
//        scenariosCollectionView.register(ScenariosCollectionViewCell.self, forCellWithReuseIdentifier: ScenariosCollectionViewCell.reuseId)
        scenariosCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        scenariosCollectionView.dataSource = self
        scenariosCollectionView.delegate = self
    }
    
}

// MARK: - Collection View DataSource
extension HomeScreenViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScenariosCollectionViewCell.reuseId, for: indexPath) as! ScenariosCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .orange
        cell.clipsToBounds = true

        return cell
    }
    
}

// MARK: - Collection View Delegate
//extension HomeScreenViewController: UICollectionViewDelegate {
//
//}

// MARK: - Collection View DelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width * 0.6, height: (collectionView.frame.height - 8) / 2)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 8
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 8
//    }
}
