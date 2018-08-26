//
//  UIImageView+URL.swift
//  Demo-iOS
//
//  Created by Thanh Turin on 8/26/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {

  func setImage(with url: URL?) {
    if let url = url {
      af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "video_placeholder"))
    }
    else {
      image = #imageLiteral(resourceName: "video_placeholder")
    }
  }

}
