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
  let limitPerPage: Int

  func getParameters() -> [String: Any] {
    return ["page": page, "limitPerPage": limitPerPage]
  }
}

enum VideoAPIResponsePayload {
  case success(hasMore: Bool, videos: [Video])
  case failure
}

class VideoAPI {

  static let shared = VideoAPI()

  func getVideo(with payload: VideoAPIRequestPayload, completions: ((VideoAPIResponsePayload) -> Void)?) {
    let parameters = payload.getParameters()

    Alamofire.request("https://api2018.wwdc.io/videos", method: .get, parameters: parameters)
      .responseJSON { (response) in
        guard let resultValue = response.result.value as? [String: Any] else {
          completions?(.failure)
          return
        }

        let hasMore = (resultValue["hasMore"] as? Bool) ?? false

        var videos = [Video]()
        if let listVideoRawData = resultValue["videos"] as? [Any] {
          for videoRawData in listVideoRawData {
            let videoJSON = JSON(videoRawData)
            videos.append(Video(videoJSON))
          }
        }

        completions?(VideoAPIResponsePayload.success(hasMore: hasMore, videos: videos))
    }
  }

}
