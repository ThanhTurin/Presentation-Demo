//
//  VideoDataSource.swift
//  Demo
//
//  Created by Thanh Turin on 8/25/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit

final class VideoDataSource: NSObject {

  var videos: [Video]!

  func registerCells(collectionView: UICollectionView) {
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
//    let cellHeight = (collectionView.frame.size.height - minimumInteritemSpacing * (CGFloat(numberOfRows) - 1) - collectionView.contentInset.top - collectionView.contentInset.bottom) / CGFloat(numberOfRows)
//    let cellLabelHeights: CGFloat = 100
//    let cellWidth = (cellHeight - cellLabelHeights) * 16.0 / 9.0
//    return CGSize(width: cellWidth, height: cellHeight)
  }

//  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//    let preloadIndexPadding = 5
//    if indexPath.row >= resourceCollection.resources.count - preloadIndexPadding {
//      if resourceCollection.state == .loaded {
//        resourceCollection.getMore()
//      }
//    }
//  }

//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    if let resource = resourceCollection.resources[safe: indexPath.row] {
//      delegate?.resourceCollectionDataSource(self, didSelectItem: resource)
//    }
//  }
}

