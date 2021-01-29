/*:
# Chapter 2.3 - Operators (Finish)
Apple provide you with pre-built functions that extend your Publishers, helping you refine your logic, and these are called **Operators**.
*/


import Foundation
import Combine


//(1) Create a new publisher operator, to square each value, using `map()`
[1,5,9]
    .publisher
    .map { $0 * $0 }
    .sink { print($0)}

//(2) Use `decode()` with `map()` to convert a REST respones to an object
let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

struct Task: Decodable {
    let id: Int
    let title: String
    let userId: Int
    let body: String
}
let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
    .map{$0.data}
    .decode(type: [Task].self, decoder: JSONDecoder())
let cancellableSink = dataPublisher
.sink(receiveCompletion: { completion in
    print(completion)
}, receiveValue: { items in
    print( "Result \(items[0].title)")
})

