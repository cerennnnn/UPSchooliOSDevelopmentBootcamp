//
//  ResultViewController.swift
//  RockPaperScissorsGame
//
//  Created by Ceren Güneş on 7.07.2023.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var usersChoiceLabel: UILabel!
    @IBOutlet var computersChoiceLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var user: String?
    var computer: String?
    var result: String?
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        if let user, let computer, let result, let score {
            usersChoiceLabel.text = user
            computersChoiceLabel.text = computer
            resultLabel.text = result
            title = "Score: \(score)"
        }
        
        activityIndicatorFunc()
    }
    
    @IBAction func playAgainButtonAct(_ sender: UIButton) {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
            self.navigationController?.popToRootViewController(animated: true)
            self.activityIndicator.stopAnimating()
        }
    }
    
    func activityIndicatorFunc() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
