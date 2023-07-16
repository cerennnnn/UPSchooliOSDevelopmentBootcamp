//
//  MainViewController.swift
//  AnimalInfos-HW3
//
//  Created by Ceren Güneş on 15.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var videosArray = [String]()
    private var photosArray = [String]()
    private var items = [String]()
    private var index = 0
    private var animalTitle = [String]()
    
    //imageName'leri almak icin sondaki .jpg'leri almak icin bir extension yaz!!
    
    private let animals: [AnimalInfo] = [
        AnimalInfo(animalVideo: "cheetah.mp4", animalImage: "cheetah", videoLink: "https://en.wikipedia.org/wiki/Cheetah"),
        AnimalInfo(animalVideo: "elephant.mp4", animalImage: "elephant", videoLink: "https://en.wikipedia.org/wiki/Elephant"),
        AnimalInfo(animalVideo: "giraffe.mp4", animalImage: "giraffe", videoLink: "https://en.wikipedia.org/wiki/Giraffe"),
        AnimalInfo(animalVideo: "gorilla.mp4", animalImage: "gorilla", videoLink: "https://en.wikipedia.org/wiki/Gorilla"),
        AnimalInfo(animalVideo: "hippo.mp4", animalImage: "hippo", videoLink: "https://en.wikipedia.org/wiki/Hippopotamus"),
        AnimalInfo(animalVideo: "lion.mp4", animalImage: "lion", videoLink: "https://en.wikipedia.org/wiki/Lion"),
        AnimalInfo(animalVideo: "ostrich.mp4", animalImage: "ostrich", videoLink: "https://en.wikipedia.org/wiki/Common_ostrich."),
        AnimalInfo(animalVideo: "zebra.mp4", animalImage: "zebra", videoLink: "https://en.wikipedia.org/wiki/Zebra.")
    ]
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var animalView: MyView!
    
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
            let myView = MyView()
            let subview = UIView()
            
            myView.imageName = animal.animalImage
            myView.animalTitle = animal.animalImage.uppercased()
            myView.webLink = animal.videoLink
            myView.openWebAct = routeWebVC()
            
            
            print(myView.webLink)
            
            index += 1
            
            if index >= animals.count {
                //error
            }
            
            myView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: myView.topAnchor),
                subview.leadingAnchor.constraint(equalTo: myView.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: myView.trailingAnchor),
                subview.bottomAnchor.constraint(equalTo: myView.bottomAnchor)
            ])
            
            subStackView.addArrangedSubview(myView)
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
    
    func routeWebVC() -> (String) -> () {
        { urlString in
            let storyboard = UIStoryboard(name: String(describing: WebViewController.self), bundle: nil)
            
            if let webVC = storyboard.instantiateViewController(withIdentifier: String(describing: WebViewController.self)) as? WebViewController {
                //closure ile hallediyoruz:
                webVC.urlString = urlString
                self.navigationController?.pushViewController(webVC, animated: true)
                
            }
        }
    }
    
}
