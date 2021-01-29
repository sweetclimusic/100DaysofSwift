/*:
# Chapter 3.5 - Challenge (Finish)
In this challenge, you will start off by creating a publisher that will call this mocking endpoint again, and get back a list of posts. You will then filter it, to only return the first post, and further filter to only return the title.
*/

import Foundation
import Combine

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

let emptyPost = Post(userId: 0, id: 0, title: "Empty", body: "No Results")

//(1) Create a `dataTaskPublisher`
let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type: [Post].self, decoder: JSONDecoder())
    .map{$0.first}
    .replaceNil(with: emptyPost)
    .compactMap({$0.title})

//(2) Subscribe to the publisher
let cancellableSink = publisher
    .sink(receiveCompletion: {completion in
        print(String(describing: completion))
    }, receiveValue: {value in
        print("returned value \(value)")
    })


