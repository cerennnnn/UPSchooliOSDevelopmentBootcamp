//
//  ButtonView.swift
//  Netflix-UI
//
//  Created by Ceren Güneş on 9.08.2023.
//

import UIKit

class ButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        
        let button = UIButton(type: .system)
        button.setTitle("Button Title", for: .normal)
        button.setImage(UIImage(named: "your_image_name"), for: .normal)
        button.tintColor = .blue // Görüntü rengi
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(button)
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        print("Button Tapped")
    }
}
