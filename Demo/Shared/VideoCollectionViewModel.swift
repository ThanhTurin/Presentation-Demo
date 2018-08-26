//
//  VideoCollectionViewModel.swift
//  Demo
//
//  Created by Thanh Turin on 8/25/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import Foundation

final class VideoCollectionViewModel {

  let title: String
  let subtitle: String
  let imageURL: URL?

  init(_ video: Video) {
    self.title = video.title
    self.subtitle = video.description
    let resourcePath = "https://devimages-cdn.apple.com/wwdc-services/images/42/" + video.staticContentId + "/" + video.staticContentId + "_wide_900x506_1x.jpg"
    self.imageURL = URL(string: resourcePath)
  }

}
