//
//  Carousel.swift
//  MovieApp
//
//  Created by FEKRANE on 14/12/2023.
//

import SwiftUI

struct Carousel<Content: View, T: Hashable>: View {
    private var content: (T) -> Content
    private var list: [T]
    private var padding: CGFloat
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width - (padding * 2)
            LazyHStack(spacing: 0) {
                let enumeratedItems = list.enumerated().map { $0 }
                ForEach(enumeratedItems, id: \.element) { index, item  in
                    content(item)
                        .opacity(index <= currentIndex + 1 ? 1.0 : 0.0)
                        .scaleEffect(index == currentIndex ? 1.0 : 0.9)
                        .offset(x:  -CGFloat(currentIndex) * cardWidth + dragOffset)
                }
            }
            .padding(padding)
            .frame(height: geometry.size.height)
            .gesture(dragGesture(geometry: geometry))
            .animation(.spring, value: dragOffset)
        }
    }
    
    init(
        padding: CGFloat = 50,
        items: [T],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.padding = padding
        self.list = items
        self.content = content
    }
    
    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation.width
            }
            .onEnded { value in
                let threshold = 50.0
                if value.translation.width < -threshold {
                    currentIndex = min(currentIndex + 1, list.count - 1)
                } else if value.translation.width > threshold {
                    currentIndex = max(currentIndex - 1, 0)
                }
            }
    }
}
