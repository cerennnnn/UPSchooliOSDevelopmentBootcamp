//
//  ViewController.swift
//  RockPaperScissorsGame
//
//  Created by Ceren Güneş on 6.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var rockButton: UIButton!
    @IBOutlet var paperButton: UIButton!
    @IBOutlet var scissorsButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var usersChoice: String = ""
    var computersChoice: String = ""
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetGame))
        
        //MARK: - change buttons corner radius
        rockButton.layer.cornerRadius = 40
        paperButton.layer.cornerRadius = 40
        scissorsButton.layer.cornerRadius = 40
        playButton.layer.cornerRadius = 5
        
        activityIndicatorFunc()
                
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scoreLabel.text = "Score: \(score)"
    }

    func play(_ usersChoice: String, _ computersChoice: GameElement) -> String {
        guard GameElement.allCases.randomElement() != nil else {
            return "Something went wrong!"
        }
        
        var resultState: GameState = .scoreless
        
        //🪨, 📃, ✂️
        switch (usersChoice, computersChoice) {
        case ("🪨", .paper), ("📃", .scissors), ("✂️", .rock):
            resultState = .lose
            score -= 1
        case ("📃", .rock), ("🪨", .scissors), ("✂️", .paper):
            resultState = .win
            score += 1
        default:
            resultState = .scoreless
        }
        
        return resultState.gameState
    }
    
    @objc func resetGame() {
        score = 0
        scoreLabel.text = "Score: \(score)"
        
        computersChoice = ""
        usersChoice = ""

        play(usersChoice, GameElement(rawValue: computersChoice ) ?? .scissors)
    }
    
    @IBAction func playButtonAct(_ sender: UIButton) {
        guard let computerElement = GameElement.allCases.randomElement() else {
            print("Something went wrong!")
            return
        }
        
        let result = play(usersChoice, computerElement)
        computersChoice = computerElement.gameElement
        
        
        if usersChoice == "" {
            showAlert()
        } else {
            //MARK: - navigate to the other screen
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "toResultVC") as? ResultViewController {
                    vc.computer = computerElement.gameElement
                    vc.user = self.usersChoice
                    vc.result = result
                    vc.score = self.score
                    
                    activityIndicator.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.activityIndicator.stopAnimating()
                }
                
            }
        }
        
       
    }
    
    
    @IBAction func userChoiceButtonAct(_ sender: UIButton) {
        guard let usersChoice = sender.titleLabel?.text else { return }
        
        self.usersChoice = usersChoice
        
        //MARK: - Fade button when clicked
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.5
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15 ) {
            UIView.animate(withDuration: 0.1) {
                sender.alpha = 1.0
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Oops!", message: "Please select one of the buttons to play.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
        
    }
    
    func activityIndicatorFunc() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

