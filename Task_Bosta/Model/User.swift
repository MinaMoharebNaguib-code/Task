//
//  User.swift
//  Task_Bosta
//
//  Created by Mina Mohareb on 18/02/2023.
//

import Foundation
import SwiftyJSON

// MARK: - User
class User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company

    init(id: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
    init(json: JSON)
    {
        self.name = json["name"].stringValue
        self.id = json["id"].intValue
        self.username = json["username"].stringValue
        self.email = json["email"].stringValue
        self.phone = json["phone"].stringValue
        self.website = json["website"].stringValue
        self.address = Address(json: json["address"])
        self.company = Company(json: json["company"])
    }
}

// MARK: - Address
class Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo

    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
    init(json: JSON)
    {
        self.street = json["street"].stringValue
        self.suite = json["suite"].stringValue
        self.city = json["city"].stringValue
        self.zipcode = json["zipcode"].stringValue
        self.geo = Geo(json: json["geo"])
    }
}

// MARK: - Geo
class Geo: Codable {
    let lat, lng: String

    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
    init(json: JSON)
    {
        self.lat = json["lat"].stringValue
        self.lng = json["lng"].stringValue
    }
}

// MARK: - Company
class Company: Codable {
    let name, catchPhrase, bs: String

    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    init(json: JSON)
    {
        self.name = json["name"].stringValue
        self.catchPhrase = json["catchPhrase"].stringValue
        self.bs = json["bs"].stringValue
    }
}
