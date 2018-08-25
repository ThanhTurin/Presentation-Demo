//
//  VideoAPI.swift
//  Demo
//
//  Created by Thanh Turin on 8/25/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct VideoAPIRequestPayload {
  let page: Int
  let limit: Int
}

class VideoAPI {

  class func getVideo(with parameters: [String: Any]? = nil, completions: (([Video]) -> Void)?) {
    Alamofire.request("https://api2018.wwdc.io/videos", method: .get, parameters: parameters)
      .responseJSON { (response) in
        guard response.result.isSuccess else { return }
        guard let listVideoRawData = response.result.value as? [Any] else { return }
        var videos = [Video]()
        for videoRawData in listVideoRawData {
          let videoJSON = JSON(videoRawData)
          videos.append(Video(videoJSON))
        }
        completions?(videos)
    }
  }

}
