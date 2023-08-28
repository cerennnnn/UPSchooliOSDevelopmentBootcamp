//
//  PickerViewController.swift
//  ContactsApp
//
//  Created by Ceren Güneş on 21.07.2023.
//

import UIKit

protocol PickerViewControllerDelegate {
    func didSelectContactType(_ type: Relations)
}

class PickerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var contactTypeLabel: UILabel!
    
    var selectedContactType: Relations?
    var delegate: PickerViewControllerDelegate?
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparePickerView()
        contactTypeLabel.text = "All Contacts"
        generateActivityIndicator()
    }
    
    private func preparePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate?.didSelectContactType(self.selectedContactType ?? .allContacts)
            self.dismiss(animated: true)
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func generateActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
}

//MARK: - PickerView Delegate & Data Source Methods

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Relations.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Relations.allCases[row].relation
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedContactType = Relations.allCases[row]
        contactTypeLabel.text = selectedContactType?.relation
    }
    
}
