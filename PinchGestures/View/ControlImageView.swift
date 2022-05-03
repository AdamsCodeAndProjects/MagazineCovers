//
//  ControlImageView.swift
//  PinchGestures
//
//  Created by adam janusewski on 5/3/22.
//

import SwiftUI

struct ControlImageView: View {
    let icon: String
    
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
