//
//  RingView.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/14/23.
//

import SwiftUI

struct RingView: View {
    var body: some View {
        Circle()
            .trim(from: 0.2, to: 1)
            .stroke(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0))
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .frame(width: 44, height: 44)
            .shadow(color: Color(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)) as! CGColor),radius: 3)
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
