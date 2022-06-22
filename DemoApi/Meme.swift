//
//  Meme.swift
//  DemoApi
//
//  Created by Hoàng Chí Nhân on 21/06/2022.
//

import Foundation
struct Status: Decodable{
    var success: Bool
    var data: Memes
}
struct Memes: Decodable {
    var memes: [Meme]
}
struct Meme: Decodable {
    let name: String
    let url: String
}
