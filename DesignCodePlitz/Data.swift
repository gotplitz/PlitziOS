//
//  Data.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/21/23.
//

import SwiftUI

struct Rendered: Codable {
     var rendered: String
}

struct ExcerptRendered: Codable {
    var rendered: String
    var protected: Bool
}

struct PostModel: Codable, Identifiable {
    var id: Int
    var title: Rendered
    var excerpt: ExcerptRendered
    var featured_media: Int
    var content: Rendered
}

struct ImageModel: Codable {
    var id: Int
    var guid: Rendered
}

class Api {
    func getThePosts(completion: @escaping ([PostModel]) -> ()) {
        guard let url = URL(string: "https://live-asa-headless-cms.pantheonsite.io/wp-json/wp/v2/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            let posts = try! JSONDecoder().decode([PostModel].self, from: data)
            
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }.resume()
        
    }
}
