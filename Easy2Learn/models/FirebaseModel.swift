//
//  FirebaseModel.swift
//  Easy2Learn
//
//  Created by NB-JF on 12.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation

protocol FirebaseModel {
    init?(dict: [String: Any]) //from JSON
    var dict: [String: Any] {get} //to dictionary/json
}
