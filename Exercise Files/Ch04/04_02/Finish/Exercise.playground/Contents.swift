/*:
# Chapter 4.2 - Custom Publishers and Subscribers (Finish)
There are times when your built-in publishers, operators and subscribers won’t do. Combine being a relatively new framework, you will end up finding missing features and functionalities, compared to more mature frameworks like ReactSwift. We should expect Apple to bridge that gap over the next few years, but in the meantime, Apple have at least given us the tools to create custom publishers and subscribers.

*/

import Foundation
import Combine

extension Publisher{
    
    func isPrimeInteger<T: BinaryInteger>() -> Publishers
        .CompactMap<Self, T> where Output == T {
            compactMap{self.isPrime($0)}
    }
    
    
    func isPrime<T: BinaryInteger>(_ n: T) -> T? {
        guard n != 2 else { return n }
        guard n % 2 != 0 && n > 1 else { return nil }

        var i = 3
        while i * i <= n {
            if (Int(n) % i) == 0 {
                return nil
            }
            i += 2
        }

        return n
    }
}

let numbers:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers
    .publisher
    .isPrimeInteger()
    .sink { print($0) }
    
