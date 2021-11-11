//
//  MoreInfo.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/31/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import Foundation

class Cast: Decodable {
    var character: String?
    var name: String?
    var id: Int?
    var profile_path: String?
}
class CastResults: Decodable {
    var cast: [Cast]
}

class Trailer: Decodable {
    var key: String?
}
class TrailerResults: Decodable {
    var results: [Trailer]
}
