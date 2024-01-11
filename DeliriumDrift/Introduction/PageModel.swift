//
//  PageModel.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/9/24.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageURL: String
    var tag: Int
    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageURL: "music", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Welcome to Delirium Drift", description: "The best app to get stuff done in an app", imageURL: "brain.filled.head.profile", tag: 0),
        Page(name: "Welcome to Delirium Drift", description: "The best app to get stuff done in an app", imageURL: "search", tag: 1),
        Page(name: "Welcome to Delirium Drift", description: "The best app to get stuff done in an app", imageURL: "music", tag: 2)
        ]
}
