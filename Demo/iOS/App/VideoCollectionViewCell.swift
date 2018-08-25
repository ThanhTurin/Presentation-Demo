//
//  VideoCollectionViewCell.swift
//  Demo
//
//  Created by Thanh Turin on 8/25/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit
import Alamorefire

class VideoCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier = "VideoCollectionViewCell"
  var viewModel: VideoCollectionViewModel! {
    didSet {
      titleLabel.text = viewModel.title
      subtitleLabel.text = viewModel.subtitle

    }
  }

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 1
    return label
  }()

  private lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 1
    return label
  }()

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = false
    imageView.backgroundColor = UIColor.red
    imageView.layer.cornerRadius = 4.0
    return imageView
  }()


}
