//
//  AnimalView.swift
//  AnimalsInfoApp
//
//  Created by Ceren Güneş on 16.07.2023.
//

import UIKit

class AnimalView: UIView {
    
    @IBOutlet weak var animalsNameLabel: UILabel!
    @IBOutlet weak var animalsImage: UIImageView!
    @IBOutlet weak var watchVideoButton: UIButton!
    @IBOutlet weak var goToLinkButton: UIButton!
    
    var webLink: String?
    var videoURL: String?
    
    var animalImageName: String? {
        didSet {
            getAnimalImage()
        }
    }
    
    var animalName: String? {
        didSet {
            getAnimalName()
        }
    }
    
    var openWebAct: ((_ urlString: String) -> ())?
    var openVideoAct: ((_ urlString: String) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        if let viewForXib = Bundle.main.loadNibNamed(String(describing: AnimalView.self), owner: self)?.first as? UIView {
            viewForXib.frame = self.bounds
            viewForXib.layer.cornerRadius = 20
            
            animalsImage.layer.cornerRadius = 20
            watchVideoButton.layer.cornerRadius = 15
            goToLinkButton.layer.cornerRadius = 15
            
            addSubview(viewForXib)
        }
    }
    
    private func getAnimalImage() {
        if let animalImageName {
            animalsImage.image = UIImage(named: animalImageName)
        }
    }
    
    private func getAnimalName() {
        if let animalName {
            animalsNameLabel.text = animalName
        }
    }
    
    @IBAction func watchVideoButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.5
        }
        
        if let videoURL {
            openVideoAct?(videoURL)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15 ) {
            UIView.animate(withDuration: 0.1) {
                sender.alpha = 1.0
            }
        }
    }
    
    @IBAction func goToLinkButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.5
        }
        
        if let webLink {
            openWebAct?(webLink)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15 ) {
            UIView.animate(withDuration: 0.1) {
                sender.alpha = 1.0
            }
        }
    }
}


