//
//  MenuView.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/6/23.
//

import SwiftUI

struct MenuView: View {
    var bgColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08043686223)
    var myIcons = #colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)
    
    var body: some View {
        // using the color picker: #colorLiteral()
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                Text("Norman Pleitez - 80% Skill Level")
                    .font(.caption)
                
                Color.white
                    .frame(width: 104, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color(bgColor).opacity(0.8))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                MenuRow(title: "Account", icon: "gear", myIcons: myIcons)
                MenuRow(title: "Billing", icon: "creditcard", myIcons: myIcons)
                MenuRow(title: "Sign Out", icon: "person.crop.circle", myIcons: myIcons)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -150)
            )
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    var myIcons: UIColor
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(myIcons))
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
