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
    @Binding var showContent: Bool
    
    // Local State
    @State var showUpdate = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Norm's Space")
                        .modifier(CustomFont(size: 30))
                    
                    Spacer()
                    
                    AvatarViews(showProfile: $showProfile)
                    
                    Button(action: { self.showUpdate.toggle()}) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .padding(.top, 2)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
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
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                
                Spacer()
            }
         
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
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
        .frame(width: width, height: height)
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

struct WatchRingsView: View {
    // Colors
    var RedColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    var OrangeColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    var LightBlueColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    var DarkBlueColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(color1: .purple, color2: .cyan, width: 44, height: 44, percent: 70, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("1 Tech Left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Must master NodeJS").modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: RedColor, color2: OrangeColor, width: 32, height: 32, percent: 54, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: LightBlueColor, color2: DarkBlueColor, width: 32, height: 32, percent: 32, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
