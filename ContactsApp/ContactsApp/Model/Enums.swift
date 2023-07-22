//
//  Enums.swift
//  ContactsApp
//
//  Created by Ceren Güneş on 22.07.2023.
//

import Foundation

enum Relations: CaseIterable {
    case allContacts
    case family
    case friend
    case work
    
    var relation: String {
        switch self {
        case .allContacts:
            return "All Contacts"
        case .family:
            return "Family"
        case .friend:
            return "Friends"
        case .work:
            return "Work"
        }
    }
}

enum Gender {
    case woman
    case man
}

enum GenderImage: CaseIterable {
    case woman
    case man
    
    var genderImage: String {
        switch self {
        case .woman:
            return "woman-avatar"
        case .man:
            return "man-avatar"
        }
    }
    
}
