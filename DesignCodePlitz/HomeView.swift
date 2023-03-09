//
//  HomeView.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarViews(showProfile: $showProfile)
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 30) {
                    ForEach(sectionData) { item in
                        SectionView(section: item)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(section.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
            }
            
            Text(section.text.uppercased())
                .padding(.bottom, 40)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14))
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)

            
        }
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Create React App", text: "React Framework", logo: "small-react-logo", image: Image(uiImage: #imageLiteral(resourceName: "responsive-website-design-service")), color: Color("card1")),
    Section(title: "Next JS", text: "React Framework", logo: "small-react-logo", image: Image(uiImage: #imageLiteral(resourceName: "Next")), color: Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))),
    Section(title: "Type Script", text: "JavaScript Subset", logo: "small-react-logo", image: Image(uiImage: #imageLiteral(resourceName: "TypeScript")), color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
]
