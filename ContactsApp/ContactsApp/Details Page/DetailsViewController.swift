//
//  DetailsViewController.swift
//  ContactsApp
//
//  Created by Ceren Güneş on 20.07.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contactRelataionLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    
    var image: String?
    var contactName: String?
    var contactRelation: String?
    var personContacts: [Contacts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //MARK: - Register Cell
        
        let nibName = UINib(nibName: Constants.detailViewControllerReuseIdentifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: Constants.detailViewControllerReuseIdentifier)
        
        navigationItem.title = ""
        
        if let image, let contactName, let contactRelation {
            imageView.image = UIImage(named: image)
            contactNameLabel.text = contactName
            contactRelataionLabel.text = contactRelation
        }
        
        collectionViewDesign()
    }
    
    private func collectionViewDesign() {
        let design = UICollectionViewFlowLayout()
        let width = self.collectionView.frame.size.width
        let height = self.collectionView.frame.size.height
        
        design.scrollDirection = .horizontal
        design.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        design.itemSize = CGSize(width: (width * 0.4) - 30, height: (height * 0.7) - 30)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = design
    }
}

// MARK: - CollectionView Delegate & Data Source Methods

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let personContacts = personContacts else { return 0 }
        return personContacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.detailViewControllerReuseIdentifier, for: indexPath) as! DetailsViewControllerCell
        
        if let personContacts {
            cell.detailImageView.image = UIImage(named: personContacts[indexPath.row].contactImage.genderImage)
            cell.detailNameLabel.text = personContacts[indexPath.row].contactName
        }
        
        cell.layer.cornerRadius = 15
        
        return cell
    }
}
