//
//  HomeView.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    // State shared
    @Binding var showProfile: Bool
    
    // Local State
    @State var showUpdate = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarViews(showProfile: $showProfile)
                
                Button(action: { self.showUpdate.toggle()}) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
                .sheet(isPresented: $showUpdate) {
                    UpdateList()
                }
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 10) {
                    ForEach(sectionData) { item in
                        GeometryReader {
                            geometry in
                            SectionView(section: item)
                                .rotation3DEffect(
                                    Angle(degrees:
                                            Double(geometry.frame(in: .global).minX - 30) / -20),
                                        axis: (x: 0, y: 10.0, z: 0))
                        }
                        .frame(width: 275, height: 275)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
                .padding(.trailing, 60)
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
