//
//  ImageView.swift
//  Netflix-UI
//
//  Created by Ceren Güneş on 9.08.2023.
//

import UIKit

class ImageView: UIView {
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setTitle("My List", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(named: "grayButtonColor")
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "crashLandingOnYou")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerImageView.frame = bounds
    }
}

extension ImageView {
    private func style() {
        
    }
    
    private func layout() {
        addSubview(headerImageView)
        addSubview(playButton)
        addSubview(listButton)
        
        // Play Button
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            playButton.widthAnchor.constraint(equalToConstant: 140),
            playButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        // List Button
        NSLayoutConstraint.activate([
            listButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            listButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            listButton.widthAnchor.constraint(equalToConstant: 140),
            listButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
