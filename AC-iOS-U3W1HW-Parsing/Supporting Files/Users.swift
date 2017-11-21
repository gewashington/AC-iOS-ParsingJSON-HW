//
//  Users.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
/*
 The main VC = title + first + last, city + state
 The Detail Page = medium picture + email + phone + cell + username
 */

//{"results":[{"gender":"male","name":{"title":"mr","first":"eugene","last":"henry"},"location":{"street":"1673 queen street","city":"cardiff","state":"oxfordshire","postcode":"F5N 9HN"},"email":"eugene.henry@example.com","login":{"username":"goldensnake288","password":"daniel1","salt":"xhhmtMjh","md5":"317f40b1d41a6ffa9c849af4296fc7f9","sha1":"d8c26eea74e15af8e99d55f5965817af358f14a8","sha256":"7f6eb7578baa01ac5a168fbf8f88f198bb62b3cfc9e0514d4016697e429fcf5a"},"dob":"1990-07-20 11:40:15","registered":"2006-02-15 17:34:59","phone":"017684 59421","cell":"0772-793-360","id":{"name":"NINO","value":"LT 08 81 96 H"},"picture":{"large":"https://randomuser.me/api/portraits/men/80.jpg","medium":"https://randomuser.me/api/portraits/med/men/80.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/men/80.jpg"},"nat":"GB"},



struct Users: Codable {
    let results: [People]
}

struct People: Codable {
    let name: FullName
    let location: Region
    let email: String
    let login: Username
    let phone: String
    let cell: String
    let picture: Photo
}

struct FullName: Codable {
    let title: String
    let first: String
    let last: String
    
}
struct Region: Codable {
    let city: String
    let state: String
}

struct Username: Codable {
    let username: String
}

struct Photo: Codable {
    let large: String
   private(set) var thumbnail: String
}
