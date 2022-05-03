//
//  ContentView.swift
//  PinchGestures
//
//  Created by adam janusewski on 5/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating: Bool = false  // Needed for animation
    @State private var imageScale: CGFloat = 1 // For double tap on image
    @State private var imageOffset: CGSize = .zero // width and height both zero
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                // MARK: - 1. PAGE IMAGE
                Image("MuskMag")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0) // changes opacity if animating
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .animation(.linear(duration: 1), value: isAnimating)  // 1 second linear animation
                    .scaleEffect(imageScale)
                // MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: { // if double tap
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5  // Scale the image x 5
                            }
                        } else {
                            resetImageState()
                        }
                    })
                
                // MARK: - 2. DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                )
            }
            // ----------------  Title  ------------------------------
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            })
            // MARK: - INFO PANEL  (circle circle)
            .overlay(
            InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
            , alignment: .top
            )
            
            // MARK: - CONTROLS
            .overlay(
                Group {
                    HStack {
                        
                        // SCALE DOWN
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        } label : {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        // RESET
                        Button {
                            resetImageState()
                        } label : {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // SCALE UP
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label : {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                        
                        Text("Controls")
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30)
                , alignment: .bottom
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
