//
//  PostList.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/21/23.
//

import SwiftUI

struct ASAPostList: View {
    
    @ObservedObject var store = DataStore()
    
    var body: some View {
        List(store.posts) { item in
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title.rendered)
                    .font(.system(.title, design: .default))
                    .bold()
                
                Text(item.excerpt.rendered)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        ASAPostList()
    }
}

