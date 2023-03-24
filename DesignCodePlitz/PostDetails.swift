//
//  PostDetails.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/21/23.
//

import SwiftUI
import SDWebImageSwiftUI

// Using UILabel
struct HTMLBody: UIViewRepresentable {

   let html: String

   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
       
        DispatchQueue.main.async {
            let finalData = "<div style=\"font-family:system-ui;font-size:1.2rem;line-height:1.7rem\" >" + String(self.html.utf8) + "</div>"
            let data = Data(finalData.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil) {
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                label.attributedText = attributedString
                label.textAlignment = .left
                label.textColor = .darkGray
                label.numberOfLines = .max
            }
        }

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}

struct PostDetails: View {
    var post: Post
    
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var body: some View {        
            VStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 8.0) {
                            HTMLTitle(show: show, html: post.title.rendered)
                                .font(.system(size: post.show ? 22 : 24, weight: .bold))
                                .foregroundColor(Color.white)
                                .frame(width: .infinity, height: 100, alignment: .top)
                            
                            HTMLText(html: post.excerpt.rendered)
                        }
                        Spacer()
                        ZStack(alignment: .trailing) {
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.white)
                            }
                            .frame(width: 30, height: 30)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                }
                .padding(show ? 30 : 20)
                .padding(.top, show ? 40 : 0)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: 230)
                .background(Color(post.CardColor))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(post.CardColor).opacity(0.3), radius: 20, x: 0, y: 20)
                
                ScrollView {
                    AsyncImage(url: post.image) {
                        image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: post.show ? screen.width - 60 : .infinity, maxHeight: 200, alignment: .top)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                    } placeholder: {

                    }.padding(10)
                    
                    VStack(alignment: .leading, spacing: 30.0) {
                        HTMLBody(html: post.content.rendered)

                    }
                    .padding(30)
                }
                .animation(.linear, value: active)
            
            }.ignoresSafeArea()
        
    }
}

struct PostDetails_Previews: PreviewProvider {
    static var previews: some View {
        PostDetails(post: postData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
    }
}
