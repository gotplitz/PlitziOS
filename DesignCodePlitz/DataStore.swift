//
//  DataStore.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/22/23.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = postData
    
    init() {
        let colors = [#colorLiteral(red: 0.01568627451, green: 0.3019607843, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0.6117647059, green: 0.06666666667, blue: 0.02745098039, alpha: 1), #colorLiteral(red: 0, green: 0.368627451, blue: 0.6117647059, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)]
        
        Api().getThePosts {
            (posts) in
            posts.forEach {
                (item) in
                self.posts.append(Post(
                    id: item.id,
                    title: Rendered(rendered: item.title.rendered),
                    excerpt: ExcerptRendered(rendered: item.excerpt.rendered, protected: false),
                    content: Rendered(rendered: item.content.rendered),
                    image: URL(string: "https://live-asa-headless-cms.pantheonsite.io/wp-content/uploads/2022/09/Luxurious-beautiful-and-energy-efficient-family-handyman-home-is-constructed-with-American-Standard-systems.-1024x1024.jpg")!,
                    logo: #imageLiteral(resourceName: "American_Standard"),
                    CardColor: colors.randomElement()!,
                    show: false))
            }
        }
    }
    

}
