//
//  ContactsModel.swift
//  ContactsApp
//
//  Created by Ceren Güneş on 20.07.2023.
//

import Foundation

struct Contacts {
    var contactName: String
    var contactImage: GenderImage
    var contactGender: Gender
    var contactRelation: Relations
    
    static let contacts = [
        Contacts(contactName: "Ross Geller", contactImage: .man, contactGender: .man, contactRelation: .family),
        Contacts(contactName: "Monica Geller", contactImage: .woman, contactGender: .woman, contactRelation: .family),
        Contacts(contactName: "Chandler Bing", contactImage: .man, contactGender: .man, contactRelation: .friend),
        Contacts(contactName: "Rachel Green", contactImage: .woman, contactGender: .woman, contactRelation: .friend),
        Contacts(contactName: "Joey Tribbiani", contactImage: .man, contactGender: .man, contactRelation: .friend),
        Contacts(contactName: "Phoebe Buffay", contactImage: .woman, contactGender: .woman, contactRelation: .friend),
        Contacts(contactName: "Jack Geller", contactImage: .man, contactGender: .man, contactRelation: .family),
        Contacts(contactName: "Judy Geller", contactImage: .woman, contactGender: .woman, contactRelation: .family),
        Contacts(contactName: "Ben Geller", contactImage: .man, contactGender: .man, contactRelation: .family),
        Contacts(contactName: "Carol Willick", contactImage: .woman, contactGender: .woman, contactRelation: .family),
        Contacts(contactName: "Gunther", contactImage: .man, contactGender: .man, contactRelation: .work),
        Contacts(contactName: "Grandma Geller", contactImage: .woman, contactGender: .woman, contactRelation: .family),
        Contacts(contactName: "Frank Buffay Jr.", contactImage: .man, contactGender: .man, contactRelation: .friend),
        Contacts(contactName: "Estelle Leonard", contactImage: .woman, contactGender: .woman, contactRelation: .work),
        Contacts(contactName: "Richard Burke", contactImage: .man, contactGender: .man, contactRelation: .friend),
        Contacts(contactName: "Emma Geller", contactImage: .woman, contactGender: .woman, contactRelation: .family),
        Contacts(contactName: "Mike Hannigan", contactImage: .man, contactGender: .man, contactRelation: .friend)
    ]
}
