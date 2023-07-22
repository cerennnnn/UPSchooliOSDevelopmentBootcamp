//
//  ContactsTableViewController.swift
//  ContactsApp
//
//  Created by Ceren Güneş on 20.07.2023.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    var contacts: [Contacts] = Contacts.contacts
    var selectedName: String = ""
    var personContactsArr: [Contacts]?
    
    private var selectedContactType: Relations? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterButtonTapped))
        
        navigationItem.rightBarButtonItem = filterButton
        
    }
    
    @objc func filterButtonTapped() {
        let storyboard = UIStoryboard(name: String(describing: PickerViewController.self), bundle: nil)
        
        if let destinationVC = storyboard.instantiateViewController(identifier: Constants.pickerViewControllerIdentifier) as? PickerViewController {
            destinationVC.modalPresentationStyle = .overCurrentContext
            destinationVC.delegate = self 
            self.present(destinationVC, animated: true)
        }
    }
    
    private func setSections() -> [Relations] {
        if let selectedContactType {
            if selectedContactType == .allContacts {
                return Relations.allCases
            }
            return [selectedContactType]
        }
        return Relations.allCases
    }
    
    private func filterContacts(_ sectionIndex: Int) -> [Contacts] {
        
        let filteredArray = Contacts.contacts.filter { $0.contactRelation == selectedContactType }
        let unfilteredArray = Contacts.contacts.filter { $0.contactRelation == Relations.allCases[sectionIndex] }
        
         personContactsArr = getPersonContact(filteredArray)
        
        if let selectedContactType {
            if selectedContactType == .allContacts {
                personContactsArr = unfilteredArray
                return unfilteredArray
            }
            personContactsArr = filteredArray
            return filteredArray
        }
        return unfilteredArray
    }
    
    private func getPersonContact(_ filteredArray: [Contacts]) -> [Contacts] {
        return filteredArray.filter { $0.contactName != selectedName }
    }
        
    // MARK: - TableView Delegate & Data Source Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return setSections().count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if setSections()[section].relation == "All Contacts" {
            return ""
        }
        return setSections()[section].relation
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterContacts(section).count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filteredContacts = filterContacts(indexPath.section)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.contactsTableViewCell, for: indexPath)
        
        cell.textLabel?.text = filteredContacts.contactName
        cell.detailTextLabel?.text = filteredContacts.contactRelation.relation
        cell.imageView?.image = UIImage(named: filteredContacts.contactImage.genderImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let filteredContacts = filterContacts(indexPath.section)[indexPath.row]
        let storyboard = UIStoryboard(name: String(describing: DetailsViewController.self), bundle: nil)
        
        selectedName = filteredContacts.contactName
        personContactsArr = getPersonContact(filterContacts(indexPath.section))
        
        if let destinationVC = storyboard.instantiateViewController(identifier: Constants.detailViewControllerCell) as? DetailsViewController {
            destinationVC.image = filteredContacts.contactImage.genderImage
            destinationVC.contactName = filteredContacts.contactName
            destinationVC.personContacts = personContactsArr
            destinationVC.contactRelation = filteredContacts.contactRelation.relation
            destinationVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
}

//MARK: - PickerViewController Delegate Methods

extension ContactsTableViewController: PickerViewControllerDelegate {
    func didSelectContactType(_ type: Relations) {
        selectedContactType = type
    }
}

