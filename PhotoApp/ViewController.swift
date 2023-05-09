//
//  ViewController.swift
//  PhotoApp
//
//  Created by Rishav Jain on 11/04/23.
//

import UIKit

class ViewController: UIViewController {

  let apiUrl = "https://api.imgflip.com/get_memes"

  let viewModel: PhotoCollectionViewModel
  let photoView: PhotoCollectionView

  init() {
    self.viewModel = PhotoCollectionViewModel()
    self.photoView = PhotoCollectionView(viewModel: viewModel)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    DispatchQueue.global().async {
      guard let url = URL(string: self.apiUrl) else {
        return
      }
      URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
        guard let data = data, error == nil else {
          print("Error decoding")
          return
        }
        do {
          let response = try JSONDecoder().decode(ResponseModel.self, from: data)
          self.viewModel.data = response.data.memes
        } catch {
          print("Decoder error")
        }
        print(self.viewModel.data[0])
        DispatchQueue.main.async {
          print(self.viewModel.data.count)
          self.view.addSubview(self.photoView)
          self.photoView.translatesAutoresizingMaskIntoConstraints = false
          self.photoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
          self.photoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
          self.photoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
          self.photoView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
          self.photoView.collectionView.reloadData()
        }

      }).resume()

    }

  }


}

