//
//  BlogList.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/17/23.
//

import SwiftUI
import SDWebImageSwiftUI

// Using UILabel
struct HTMLText: UIViewRepresentable {

   let html: String

   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
       
        DispatchQueue.main.async {
            let data = Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                label.attributedText = attributedString
                label.textAlignment = .left
                label.font = .systemFont(ofSize: 14)
                label.textColor = .white
                label.layer.opacity = 0.8
                label.numberOfLines = 3
            }
        }

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}

// Using UILabel
struct HTMLTitle: UIViewRepresentable {
    let show: Bool
    let html: String

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
       
        DispatchQueue.main.async {
            let data = Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                label.attributedText = attributedString
                label.textAlignment = .left
                label.font = .systemFont(ofSize: show ? 22 : 24, weight: .heavy)
                label.textColor = .white
                label.numberOfLines = 4
                label.lineBreakMode = NSLineBreakMode.byTruncatingTail
                label.sizeToFit()
            }
        }

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}

struct BlogList: View {
//    @State var BlogPosts = postData
    @ObservedObject var store = DataStore()
    
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    
    @State var posts: [PostModel] = []
    var body: some View {
        
        ZStack {
            Color.black.opacity(Double(self.activeView.height/500))
                .animation(.linear, value: active)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack (spacing: 30) {
                    Text("ASA Blog")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(store.posts.indices, id: \.self) {
                        index in
                        GeometryReader {
                            geometry in
                            PostView(
                                show: self.$store.posts[index].show,
                                post: self.store.posts[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex,
                                activeView: self.$activeView
                            )
                                .offset(y: self.store.posts[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.store.posts[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.store.posts[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: true)
            }
            .statusBar(hidden: active ? true : false)
            .scrollIndicators(.hidden)
            .animation(.linear, value: active)
        }
    }
}

struct BlogList_Previews: PreviewProvider {
    static var previews: some View {
        BlogList()
    }
}

struct PostView: View {
    // State
    @Binding var show: Bool
    
    // Data Model
    var post: Post
    
    @Binding var active: Bool
    
    // To manipulate the non active cards
    var index: Int
    @Binding var activeIndex: Int
    
    // To manipulate active card
    @Binding var activeView: CGSize
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                HTMLText(html: post.content.rendered)

            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 360 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        HTMLTitle(show: self.show, html: post.title.rendered)
                            .frame(width: .infinity, height: 58, alignment: .top)
                        
                        VStack() {
                            HTMLText(html: post.excerpt.rendered)
                        }
                        
                    }
                    Spacer()
                    ZStack(alignment: .trailing) {
                        Image(uiImage: post.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.white)
                        }
                        .frame(width: 30, height: 30)
                            .background(Color.black)
                            .clipShape(Circle())
                            .opacity(show ? 1 : 0)
                    }
                    
                }
                
                Spacer()
                
                AsyncImage(url: post.image) {
                    image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: post.show ? screen.width - 60 : .infinity, maxHeight: post.show ? 130 : 100, alignment: .top)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                } placeholder: {

                }

            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 40 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 360 : 280)
            .background(Color(post.CardColor))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(post.CardColor).opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            
            if show {
                PostDetails(post: post, show: $show, active: $active, activeIndex: $activeIndex)
                    .background(Color.white)
                    .animation(nil, value: show)
            }
            
        }
        .frame(height: post.show ? screen.height : 280)
        .scaleEffect(1 - (self.activeView.height / 1000))
        .rotation3DEffect(Angle(degrees: self.show ? Double(self.activeView.height / 10) : 0), axis: (x: 0, y: 10.0, z: 0))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: show)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Post: Identifiable {
    var id: Int
    var title: Rendered
    var excerpt: ExcerptRendered
    var content: Rendered
    var image: URL
    var logo: UIImage
    var CardColor: UIColor
    var show: Bool
}

var postData = [
   Post(
    id: 7001,
    title: Rendered(rendered: "Preparing Your Home for Winter"),
    excerpt: ExcerptRendered(rendered:  "Featured News", protected: false),
    content: Rendered(rendered: "\n<p class=\"has-text-16-leading-6-font-size\">Nothing is more frustrating than when your <a href=\"/resources/glossary/hvac/\">HVAC system</a> stops working when you need it most, causing you to consider an emergency air conditioning and furnace <a href=\"/resources/repair-and-replace/\">repair or replacement</a>. Not only is it stressful for you and your family to be without air conditioning or heat, but it can also be a financial burden. There are a few things you can do, however, before calling a technician.</p>\n\n\n\n<h2 class=\"has-text-22-leading-7-font-size\" id=\"emergency-air-conditioning-and-furnace-repair-checklist\" style=\"font-style:normal;font-weight:600\">Emergency Air Conditioning and Furnace Repair Checklist</h2>\n\n\n\n<ul class=\"has-text-16-leading-6-font-size\">\n<li><strong>Check your furnace’s air filter.</strong> If you have not replaced or cleaned it in a while, you may want to purchase a new one, since a dirty filter can restrict airflow through your home.</li>\n\n\n\n<li><strong>Check your circuit breakers.</strong> The breaker switch may have tripped or shut off by accident. It is important to keep in mind that a tripped HVAC breaker may indicate a more serious issue, so schedule an inspection with your local American Standard Customer Care dealer immediately.</li>\n\n\n\n<li><strong>Make sure the vents in your home are not obstructed.</strong> Blocked or closed vents can limit the airflow through your home.</li>\n\n\n\n<li><strong>Check the thermostat.</strong> If your thermostat uses a battery, it could need to be changed. You can also check to see if there is dust or dirt in the thermostat by removing the faceplate. If there is dust or dirt, use a can of compressed air to gently remove it.</li>\n\n\n\n<li><strong>Set the thermostat temperature and be patient</strong>. Frequently changing the temperature on the thermostat can cause the compressor in your system to overheat and shut down. To avoid this, be patient once you set your desired temperature; it could take up to 5 minutes for the system to turn on.</li>\n</ul>\n\n\n\n<p class=\"has-text-16-leading-6-font-size\">If after going through this checklist your unit is still not functioning properly it may be time to call a technician. A malfunctioning HVAC system could drive up your energy costs along with the expensive emergency furnace and air conditioning repairs, so the faster you can figure out if you need a technician the better. Our&nbsp;<a href=\"/find-your-dealer/\">American Standard Customer Care dealers</a> can come to your home to assess the situation and make suggests for, and complete, a repair.</p>\n\n\n\n<div id=\"\">\n  <h3>Block: Spacer &#8211; Responsive</h3>\n  <p>\n    <b>Small Viewport:</b> pb-8<br />\n    <b>Small Left Spacing:</b> pl-0<br />\n    <b>Small Right Spacing:</b> pr-0<br />\n    <b>Medium Viewport:</b> pb-8<br />\n    <b>Medium Left Spacing:</b> pl-0<br />\n    <b>Medium Right Spacing:</b> pr-0<br />\n    <b>Large Viewport:</b> pb-8<br />\n    <b>Large Left Spacing:</b> pl-0<br />\n    <b>Large Right Spacing:</b> pr-0<br />\n    <b>Extra Large Viewport:</b> pb-8<br />\n    <b>Extra Large Left Spacing:</b> pl-0<br />\n    <b>Extra Large Right Spacing:</b> pr-0  </p>\n</div>\n\n\n\n<div>&#8212;&#8211;</div>\n\n\n<div class=\"is-layout-flex wp-container-15 wp-block-columns px-0 social-sharing\">\n<div class=\"is-layout-flow wp-block-column is-vertically-aligned-center\">\n<p class=\"has-text-align-center font-semibold mt-8 md:mt-0 mb-0 md:text-left has-text-18-leading-7-font-size\" style=\"font-style:normal;font-weight:600\">Share this article</p>\n</div>\n\n\n\n<div class=\"is-layout-flow wp-block-column is-vertically-aligned-center mx-auto md:ml-auto\"><div style=\"background-color: #f8f8f8\"><h2>Choose your icons</h2></div></div>\n</div>\n\n\n\n<div class=\"is-layout-flow wp-block-group flex flex-col\"><div class=\"wp-block-group__inner-container\">\n<div id=\"\">\n  <h3>Block: Spacer &#8211; Responsive</h3>\n  <p>\n    <b>Small Viewport:</b> pb-10<br />\n    <b>Small Left Spacing:</b> <br />\n    <b>Small Right Spacing:</b> <br />\n    <b>Medium Viewport:</b> pb-10<br />\n    <b>Medium Left Spacing:</b> <br />\n    <b>Medium Right Spacing:</b> <br />\n    <b>Large Viewport:</b> pb-10<br />\n    <b>Large Left Spacing:</b> <br />\n    <b>Large Right Spacing:</b> <br />\n    <b>Extra Large Viewport:</b> pb-10<br />\n    <b>Extra Large Left Spacing:</b> <br />\n    <b>Extra Large Right Spacing:</b>   </p>\n</div>\n\n\n\n<h3 class=\"has-text-align-left mt-0 mb-0 has-text-22-leading-7-font-size\" id=\"related-articles\">Related articles</h3>\n\n\n\n<div id=\"\">\n  <h3>Block: Spacer &#8211; Responsive</h3>\n  <p>\n    <b>Small Viewport:</b> pb-2<br />\n    <b>Small Left Spacing:</b> pl-0<br />\n    <b>Small Right Spacing:</b> pr-0<br />\n    <b>Medium Viewport:</b> pb-2<br />\n    <b>Medium Left Spacing:</b> pl-0<br />\n    <b>Medium Right Spacing:</b> pr-0<br />\n    <b>Large Viewport:</b> pb-4<br />\n    <b>Large Left Spacing:</b> pl-0<br />\n    <b>Large Right Spacing:</b> pr-0<br />\n    <b>Extra Large Viewport:</b> pb-4<br />\n    <b>Extra Large Left Spacing:</b> pl-0<br />\n    <b>Extra Large Right Spacing:</b> pr-0  </p>\n</div>\n</div></div>\n\n\n"),
    image: URL(string: "https://live-asa-headless-cms.pantheonsite.io/wp-content/uploads/2022/09/Preparing-Your-Home-for-Winter.jpg")!,
    logo: #imageLiteral(resourceName: "American_Standard"),
    CardColor: #colorLiteral(red: 0.01568627451, green: 0.3019607843, blue: 0.4901960784, alpha: 1),
    show: false
   ),
//   Post(
//    id: 7002,
//    title: Rendered(rendered: "HVAC Safety Tips"),
//    excerpt: ExcerptRendered(rendered:  "HVAC Tips & Tricks", protected: false),
//    image: URL(string: "https://live-asa-headless-cms.pantheonsite.io/wp-content/uploads/2022/09/HVAC-Safety-Tips.jpg")!,
//    logo: #imageLiteral(resourceName: "American_Standard"),
//    CardColor: #colorLiteral(red: 0.6117647059, green: 0.06666666667, blue: 0.02745098039, alpha: 1),
//    show: false
//   ),
//   Post(
//    id: 7003,
//    title: Rendered(rendered: "What’s Keeping the Getaway Comfortable?"),
//    excerpt: ExcerptRendered(rendered:  "About American Standard", protected: false),
//    image: URL(string: "https://live-asa-headless-cms.pantheonsite.io/wp-content/uploads/2022/09/Luxurious-beautiful-and-energy-efficient-family-handyman-home-is-constructed-with-American-Standard-systems.-1024x1024.jpg")!,
//    logo: #imageLiteral(resourceName: "American_Standard"),
//    CardColor: #colorLiteral(red: 0, green: 0.368627451, blue: 0.6117647059, alpha: 1),
//    show: false
//   )
]
