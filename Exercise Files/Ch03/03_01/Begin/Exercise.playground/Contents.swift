/*:
# Chapter 3.1 - dataTaskPublisher (Begin)
You can make use of the foundational framework library, URLSession, and in particular, the `dataTaskPublisher` instance to make URL requests.
*/

import Foundation
import Combine

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
let samplePost = Post(userId: 1, id: 2, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")

//(1) Create a `dataTaskPublisher`


//(2) Subscribe to the publisher
