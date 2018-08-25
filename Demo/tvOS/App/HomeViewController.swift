//
//  HomeViewController.swift
//  Demo-tvOS
//
//  Created by Thanh Turin on 8/19/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {

  private lazy var dataSource: VideoDataSource = {
    let dataSource = VideoDataSource()
    dataSource.delegate = self
    return dataSource
  }()

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumInteritemSpacing = 60
    flowLayout.minimumLineSpacing = 60

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.contentInset = UIEdgeInsets(top: 60, left: 40, bottom: 60, right: 40)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = UIColor.white
    collectionView.alwaysBounceVertical = true

    collectionView.dataSource = dataSource
    collectionView.delegate = dataSource
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    registerCollectionView()
    fetchData()
  }

  private func registerCollectionView() {
    dataSource.registerCells(for: collectionView)
  }

  private func fetchData() {
    VideoAPI.getVideo { (videos) in
      self.dataSource.videos = videos
      self.collectionView.reloadData()
    }
  }

  private func setupView() {
    view.addSubview(collectionView)

    let views: [String: UIView] = [
      "collectionView": collectionView,
      ]

    var constraints = [NSLayoutConstraint]()
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: [], metrics: nil, views: views)
    constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: [], metrics: nil, views: views)

    NSLayoutConstraint.activate(constraints)
  }

  private func playVideo(_ video: Video) {
    guard let videoURL = URL(string: video.mediaURL) else {
      return
    }

    let playerViewController = AVPlayerViewController()
    playerViewController.player = AVPlayer(url: videoURL)

    present(playerViewController, animated: true) {
      playerViewController.player?.play()
    }
  }

}

extension HomeViewController: VideoDataSourceDelegate {
  func videoDataSource(_ dataSource: VideoDataSource, didSelect video: Video) {
    playVideo(video)
  }

  func videoDataSource(_ dataSource: VideoDataSource, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (collectionView.frame.size.height - 180) / 2.0
    let cellLabelsHeights: CGFloat = 170
    let width = (height - cellLabelsHeights) * 16.0 / 9.0
    return CGSize(width: width, height: height)
  }

}
