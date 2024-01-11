//
//  IntroView.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/9/24.
//

import SwiftUI

struct IntroView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    @State private var showContentView = false // State to control ContentView presentation

    var body: some View {
        NavigationView {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        Spacer()
                        PageView(page: page)
                        Spacer()
                        if page == pages.last {
                            Button("Sign up", action: {
                                showContentView = true // Set the state to true to show ContentView
                            })
                            .buttonStyle(.bordered)
                            .fullScreenCover(isPresented: $showContentView, content: {
                                ContentView()
                            })
                        } else {
                            Button("Next", action: incrementPage)
                        }
                        Spacer()
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .black
                dotAppearance.pageIndicatorTintColor = .gray
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func incrementPage() {
        pageIndex += 1
    }
}

#Preview {
    IntroView()
}
