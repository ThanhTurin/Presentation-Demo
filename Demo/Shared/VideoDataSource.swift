//
//  VideoDataSource.swift
//  Demo
//
//  Created by Thanh Turin on 8/25/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit

protocol VideoDataSourceDelegate: AnyObject {
  func videoDataSource(_ dataSource: VideoDataSource, sizeForItemAt indexPath: IndexPath) -> CGSize
  func videoDataSource(_ dataSource: VideoDataSource, didSelect video: Video)
}

final class VideoDataSource: NSObject {

  var videos = [Video]()
  weak var delegate: VideoDataSourceDelegate?

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.reuseIdentifier)
  }

}

extension VideoDataSource: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseIdentifier, for: indexPath) as? VideoCollectionViewCell else {
      return UICollectionViewCell()
    }

    let video = videos[indexPath.row]
    let viewModel = VideoCollectionViewModel(video)
    cell.viewModel = viewModel
    return cell
  }

}

extension VideoDataSource: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let delegate = delegate else {
      return CGSize.zero
    }
    return delegate.videoDataSource(self, sizeForItemAt: indexPath)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.videoDataSource(self, didSelect: videos[indexPath.row])
  }


//  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//    let preloadIndexPadding = 5
//    if indexPath.row >= resourceCollection.resources.count - preloadIndexPadding {
//      if resourceCollection.state == .loaded {
//        resourceCollection.getMore()
//      }
//    }
//  }

}

