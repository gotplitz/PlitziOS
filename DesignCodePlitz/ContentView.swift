//
//  ContentView.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/4/23.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .animation(.default, value: show)
            
            BackCardView()
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.4), value: show)
            
            BackCardView()
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.2), value: show)
            
            CardView()
                .offset(x: viewState.width, y: viewState.height)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0), value: viewState)
                .onTapGesture {
                    self.show.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged {
                            value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded {
                            value in
                            self.viewState = .zero
                            self.show = false
                        }
            )
            
            BottomCardView()
                .blur(radius: show ? 20 : 0)
                .animation(.default, value: show)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("MERN Stack")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .frame(width: 200, alignment: .leading)
                        
                    Text("JavaScript")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                    .padding()
                Image("small-react-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
            }.padding(.horizontal, 20).padding(.top, 20)
            Spacer()
            Image("responsive-website-design-service")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y: -40)
                .frame(width: 300, height: 110, alignment: .top)
        }.frame(width: 340.0, height: 220.0).background(Color.primary).cornerRadius(20).shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }.frame(width: 340, height: 220)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Norman's Skills")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle().frame(width: 40, height: 5).cornerRadius(3).opacity(0.1)
            Text("MERN stands for Mongo (a NoSQL database), Express (a NodeJS framework), React (A front-end library) and Node (a server environment). All based on JavaScript programing language.").multilineTextAlignment(.center).font(.subheadline).lineSpacing(4)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        .offset(x: 0, y: 500)
    }
}
