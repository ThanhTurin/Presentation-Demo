//
//  Video.swift
//  Demo
//
//  Created by Thanh Turin on 8/25/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Video {

  let id: String
  let title: String
  let description: String
  let mediaURL: String
  let staticContentId: String

  var imageURL: String {
    return "https://devimages-cdn.apple.com/wwdc-services/images/42/" + staticContentId + "/" + staticContentId + "_wide_900x506_1x.jpg"
  }

  init(_ json: JSON) {
    self.id = json["id"].stringValue
    self.title = json["title"].stringValue
    self.description = json["description"].stringValue
    self.mediaURL = json["media"]["hls"].stringValue
    self.staticContentId = json["staticContentId"].stringValue
  }

}
