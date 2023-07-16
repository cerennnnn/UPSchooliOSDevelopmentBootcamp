//
//  MainViewController.swift
//  AnimalsInfoApp
//
//  Created by Ceren Güneş on 16.07.2023.
//

import UIKit
import AVKit
import AVFoundation

class MainViewController: UIViewController {
    
    //activity indicator ekle!!!
    
    @IBOutlet weak var animalView: AnimalView!
    @IBOutlet weak var contentView: UIView!
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    let fileManager = FileManager.default

    private var index = 0
    
    private let animals: [AnimalInfo] = [
        AnimalInfo(animalVideo: "cheetah.mp4", animalImage: "cheetah", animalInfoLink: "https://en.wikipedia.org/wiki/Cheetah"),
        AnimalInfo(animalVideo: "elephant.mp4", animalImage: "elephant", animalInfoLink: "https://en.wikipedia.org/wiki/Elephant"),
        AnimalInfo(animalVideo: "giraffe.mp4", animalImage: "giraffe", animalInfoLink: "https://en.wikipedia.org/wiki/Giraffe"),
        AnimalInfo(animalVideo: "gorilla.mp4", animalImage: "gorilla", animalInfoLink: "https://en.wikipedia.org/wiki/Gorilla"),
        AnimalInfo(animalVideo: "hippo.mp4", animalImage: "hippo", animalInfoLink: "https://en.wikipedia.org/wiki/Hippopotamus"),
        AnimalInfo(animalVideo: "lion.mp4", animalImage: "lion", animalInfoLink: "https://en.wikipedia.org/wiki/Lion"),
        AnimalInfo(animalVideo: "ostrich.mp4", animalImage: "ostrich", animalInfoLink: "https://en.wikipedia.org/wiki/Common_ostrich."),
        AnimalInfo(animalVideo: "zebra.mp4", animalImage: "zebra", animalInfoLink: "https://en.wikipedia.org/wiki/Zebra.")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Animals"
        setupMyViews()
        
    }
    
    private func setupMyViews() {
        let stackView = createStackView()
        contentView.addSubview(stackView)
        positionStackView(stackView)
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        for _ in 1...4 {
            let subStackView = createSubStackView()
            stackView.addArrangedSubview(subStackView)
        }
        
        return stackView
    }
    
    private func createSubStackView() -> UIStackView {
        let subStackView = UIStackView()
        subStackView.axis = .horizontal
        subStackView.alignment = .fill
        subStackView.distribution = .fillEqually
        subStackView.spacing = 15
        
        for _ in 1...2 {
            let animal = animals[index]
            let animalView = AnimalView()
            
            animalView.animalImageName = animal.animalImage
            animalView.animalName = animal.animalImage.uppercased()
            animalView.webLink = animal.animalInfoLink
            animalView.openWebAct = routeWebVC()
            animalView.videoURL = animal.animalVideo
            animalView.openVideoAct = { [weak self] videoURL in
                self?.openVideo(in: videoURL)
                   }
            
            index += 1
            
            if index >= animals.count {
                index = 0
            }
            
            subStackView.addArrangedSubview(animalView)
        }
        
        return subStackView
    }
    
    private func positionStackView(_ stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func routeWebVC() -> (String) -> () {
        { urlString in
            let storyboard = UIStoryboard(name: String(describing: WebViewController.self), bundle: nil)
            
            if let webVC = storyboard.instantiateViewController(withIdentifier: String(describing: WebViewController.self)) as? WebViewController {
                
                webVC.urlString = urlString
                
            self.navigationController?.pushViewController(webVC, animated: true)
            }
        }
    }

    private func openVideo(in videoURL: String) {
    
        if let videosURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Videos"),
           let _ = Bundle.main.url(forResource: videoURL, withExtension: "") {

            if !fileManager.fileExists(atPath: videosURL.path) {
                do {
                    try fileManager.createDirectory(at: videosURL, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("error: \(error.localizedDescription)")
                    return
                }
            }
            
            playVideo(at: videosURL.appendingPathComponent("\(videoURL)"))
            
        }
    }
    
    func playVideo(at videoURL: URL) {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}

