//
//  PhotoCollectionViewModel.swift
//  PhotoApp
//
//  Created by Rishav Jain on 12/04/23.
//

import UIKit

class PhotoCollectionViewModel {
  var data: [Meme]
  init() {
    self.data = [Meme]()
  }
  func numberOfItemsPerRow() -> Int {
    return 3
  }

  func numberOfRows() -> Int {
    return 8
  }

  func getData(for cell: Int) -> Meme {
    return data[cell]
  }
}
