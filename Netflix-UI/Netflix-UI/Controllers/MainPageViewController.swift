//
//  ViewController.swift
//  Netflix-UI
//
//  Created by Ceren Güneş on 8.08.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    
    let sectionTitles = ["Trending Now", "New Releases", "TV Dramas", "Quirky Romantic TV Shows", "My List"]
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        style()
        layout()
        configureNavBar()
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "logo")
        
        if let originalImage = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal) {
            let newWidth: CGFloat = 20
            let newHeight: CGFloat = 40
            
            if let resizedImage = resizeImage(image: originalImage, newWidth: newWidth, newHeight: newHeight) {
                image = resizedImage.withRenderingMode(.alwaysOriginal)
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        let searchIcon = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil)
        let tvIcon = UIBarButtonItem(image: UIImage(systemName: "tv"), style: .done, target: self, action: nil)
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItems = [searchIcon, tvIcon]
                
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

extension MainPageViewController {
    private func style() {
        let headerImageView = ImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        
        tableView.tableHeaderView = headerImageView
    }

    private func layout() {
        view.addSubview(tableView)
    }
}

//MARK: - UITableViewController Delegate & DataSource
extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.setData(data: Shows.firstSectionTvShows)
        } else if indexPath.section == 1 {
            cell.setData(data: Shows.secondSectionTvShows)
        } else if indexPath.section == 2 {
            cell.setData(data: Shows.thirdSectionTvShows)
        } else if indexPath.section == 3 {
            cell.setData(data: Shows.fourthSectionTvShows)
        } else if indexPath.section == 4 {
            cell.setData(data: Shows.fifthSectionTvShows)
        }
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.height, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}

extension MainPageViewController: ResizeImageProtocol {
    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
