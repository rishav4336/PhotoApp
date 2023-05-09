//
//  PhotoCollectionView.swift
//  PhotoApp
//
//  Created by Rishav Jain on 12/04/23.
//

import UIKit
import Kingfisher

class PhotoCollectionView: UIView {

  lazy var collectionView: UICollectionView = {
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    collectionViewFlowLayout.minimumLineSpacing = 0
    collectionViewFlowLayout.minimumInteritemSpacing = 0
    var view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    view.dataSource = self
    view.delegate = self
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 1
    view.translatesAutoresizingMaskIntoConstraints = false
    view.register(PhotoCVCell.self, forCellWithReuseIdentifier: PhotoCVCell.cellreuseIdentifier)
    return view
  }()

  var viewModel: PhotoCollectionViewModel


  init(viewModel: PhotoCollectionViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    self.addSubview(collectionView)
    collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PhotoCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.data.count
    
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCVCell.cellreuseIdentifier, for: indexPath)

    let cellVO = viewModel.getData(for: indexPath.row)

    if let cell = cell as? PhotoCVCell {
      cell.configure(cellVO: cellVO)
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: CGFloat(Int(UIScreen.main.bounds.width)/viewModel.numberOfItemsPerRow()), height: CGFloat(Int(UIScreen.main.bounds.height)/viewModel.numberOfRows()))
  }


}

class PhotoCVCell: UICollectionViewCell {
  static var cellreuseIdentifier: String {
    return String(describing: self)
  }

  let imageView: UIImageView = {
    var imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    imageView.backgroundColor = .white

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(cellVO: Meme) {
    let url = URL(string: cellVO.url)
    imageView.kf.setImage(with: url)
  }
}
