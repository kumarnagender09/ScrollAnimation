//
//  ContentView.swift
//  ScrollAnimation
//
//  Created by Nagender Kumar on 02/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var headerHeight: CGFloat = 300
    @State private var previousScrollOffset: CGFloat = 0
    
    let minHeight: CGFloat = 90
    let maxHeight: CGFloat = 300
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Top Green Header
            VStack {
                HStack {
                    TextField("Search", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
            }
            .frame(height: headerHeight)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .clipShape(
                RoundedCorner(radius: 24, corners: [.bottomLeft, .bottomRight])
            )
            .animation(.easeInOut(duration: 0.2), value: headerHeight)
            
            // 5-pixel gap
            Color.clear.frame(height: 5)
            
            // MARK: Scrollable White View
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(1...50, id: \.self) { i in
                        Text("Item \(i)")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(14)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 16)
                .background(
                    GeometryReader { geo -> Color in
                        let offset = geo.frame(in: .named("scroll")).minY
                        DispatchQueue.main.async {
                            updateHeaderHeight(offset: offset)
                        }
                        return Color.clear
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            .background(Color.white)
            .clipShape(
                RoundedCorner(radius: 24, corners: [.topLeft, .topRight])
            )
            .edgesIgnoringSafeArea(.bottom)
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.black)
    }
    
    // MARK: Header-first Scroll Logic with Snap
    private func updateHeaderHeight(offset: CGFloat) {
        let delta = offset - previousScrollOffset
        
        // Scroll down (pull content down)
        if delta > 0 {
            if headerHeight < maxHeight {
                headerHeight = min(maxHeight, headerHeight + delta)
            }
        }
        
        // Scroll up (push content up)
        if delta < 0 {
            if headerHeight > minHeight {
                headerHeight = max(minHeight, headerHeight + delta)
            }
        }
        
        previousScrollOffset = offset
        
        // 🔹 Snap header when top item is visible (fast scroll fix)
        if offset >= 0 { // First record fully visible
            if headerHeight < maxHeight {
                headerHeight = maxHeight
            }
        }
    }
}

// MARK: Rounded Corner Shape
struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ContentView()
}
