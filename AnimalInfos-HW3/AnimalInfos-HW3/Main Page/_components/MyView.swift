//
//  MyView.swift
//  AnimalInfos-HW3
//
//  Created by Ceren Güneş on 15.07.2023.
//

import UIKit

class MyView: UIView {
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var animalName: UILabel!
    
    var webLink: String?

    var openWebAct: ((_ urlString: String) -> ())?
    
    var imageName: String? {
        didSet {
            getAnimalImage()
        }
    }
    
    var animalTitle: String? {
        didSet {
            getAnimalName()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        if let viewForXib = Bundle.main.loadNibNamed(String(describing: MyView.self), owner: self)?[0] as? UIView {
            viewForXib.frame = self.bounds
            viewForXib.layer.cornerRadius = 20
            
            animalImage.layer.cornerRadius = 15

            addSubview(viewForXib)
        }
    }
    
    @IBAction func watchVideoButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func goToLinkButtonTapped(_ sender: UIButton) {
        sender.isEnabled = true
        print("go to link butonun tiklandi.")

        if let webLink {
            openWebAct?(webLink)
        }
    }
    
    private func getAnimalImage() {
        if let imageName {
            animalImage.image = UIImage(named: imageName)
        }
    }
    
    private func getAnimalName() {
        if let animalName {
            animalName.text = animalTitle
        }
    }
    
//    private func getVideoLink() -> String? {
//        if let videoLink = webLink {
//            webLink = videoLink
//            return videoLink
//        }
//        return nil
//    }
    
}
