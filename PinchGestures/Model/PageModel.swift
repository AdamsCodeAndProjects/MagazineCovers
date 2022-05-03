//
//  PageModel.swift
//  PinchGestures
//
//  Created by adam janusewski on 5/3/22.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return imageName
    }
}
