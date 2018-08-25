//
//  VideoCollectionViewCell.swift
//  Demo-tvOS
//
//  Created by Thanh Turin on 8/25/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit
import AlamofireImage

class VideoCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier = "VideoCollectionViewCell"

  var viewModel: VideoCollectionViewModel! {
    didSet {
      titleLabel.text = viewModel.title
      subtitleLabel.text = viewModel.subtitle
      imageView.af_setImage(withURL: viewModel.imageURL)
    }
  }

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 32)
    return label
  }()

  private lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 28)
    label.numberOfLines = 2
    return label
  }()

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = false
    imageView.adjustsImageWhenAncestorFocused = true
    return imageView
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  private func setupViews() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subtitleLabel)

    let views: [String: UIView] = [
      "imageView": imageView,
      "titleLabel": titleLabel,
      "subtitleLabel": subtitleLabel,
    ]

    var constraints = [NSLayoutConstraint]()

    constraints += [
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16.0 / 9.0)
    ]

    constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]-20-[titleLabel]-10-[subtitleLabel]", options: [.alignAllLeading, .alignAllTrailing], metrics: nil, views: views)
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: views)

    NSLayoutConstraint.activate(constraints)
  }

}
