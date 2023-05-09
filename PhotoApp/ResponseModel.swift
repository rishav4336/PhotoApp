//
//  ResponseModel.swift
//  PhotoApp
//
//  Created by Rishav Jain on 12/04/23.
//

import Foundation

struct ResponseModel: Codable {
  let success: Bool
  let data: Memes
}

struct Memes: Codable {
  let memes: [Meme]
}

struct Meme: Codable {
  let id: String
  let name: String
  let url: String
  let width : Int
  let height : Int
  let boxCount : Int

  enum CodingKeys : String, CodingKey{
      case id, name, url, width, height
      case boxCount = "box_count"
  }
  
}

// "id":"181913649","name":"Drake Hotline Bling","url":"https:\/\/i.imgflip.com\/30b1gx.jpg","width":1200,"height":1200,"box_count":2,"captions":0
