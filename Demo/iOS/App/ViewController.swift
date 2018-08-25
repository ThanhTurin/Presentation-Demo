//
//  ViewController.swift
//  Demo
//
//  Created by Thanh Turin on 8/19/18.
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var minimumInteritemSpacing: CGFloat! = 20
  var numberOfColumn: Int! = 2

  override func viewDidLoad() {
    super.viewDidLoad()

    VideoAPI.getVideo { (videos) in
      print(videos.count)
    }
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController {

  func videoCellSize() -> CGSize {
    let cellWidth = (view.frame.width - 30) / 2
    let cellHeight = cellWidth * 9.0 / 16.0 + 40
    return CGSize(width: cellWidth, height: cellHeight)

  }

}

