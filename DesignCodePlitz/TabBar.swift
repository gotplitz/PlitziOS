//
//  TabBar.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/12/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem{
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Softwares")
            }
            BlogList().tabItem {
                Image(systemName: "list.bullet.below.rectangle")
                Text("Blog Posts")
            }
//            ASAPostList().tabItem {
//                Image(systemName: "ellipsis.viewfinder")
//                Text("ASA List")
//            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar()
        }
    }
}
