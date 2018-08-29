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
  func videoDataSource(_ dataSource: VideoDataSource, didRetrivedData videos: [Video])
}

final class VideoDataSource: NSObject {

  private weak var delegate: VideoDataSourceDelegate?

  private var shouldLoadMore = true
  private var videos = [Video]()

  private let videoAPI: VideoAPI
  private var currentPage: Int = 1
  private let limitPerPage = 10
  private var isLoading: Bool = false

  init(delegate: VideoDataSourceDelegate?,
       videoAPI: VideoAPI = VideoAPI.shared
    ) {
    self.delegate = delegate
    self.videoAPI = videoAPI
  }

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.reuseIdentifier)
  }

  func fetchData() {
    isLoading = true

    let requestPayload = VideoAPIRequestPayload(page: currentPage, limitPerPage: limitPerPage)
    videoAPI.getVideo(with: requestPayload) { [weak self] (response) in
      self?.updateData(with: response)
      self?.isLoading = false
    }
  }

  private func updateData(with response: VideoAPIResponsePayload) {
    switch response {
    case .success(hasMore: let hasMore, videos: let videos):
      self.shouldLoadMore = hasMore
      self.videos += videos
      delegate?.videoDataSource(self, didRetrivedData: videos)

    case .failure:
      self.shouldLoadMore = false
    }
  }

  private func fetchNextPage() {
    currentPage += 1
    fetchData()
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

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let preloadIndexPadding = 5
    if indexPath.row >= videos.count - preloadIndexPadding {
      if shouldLoadMore && !isLoading {
        fetchNextPage()
      }
    }
  }

}

