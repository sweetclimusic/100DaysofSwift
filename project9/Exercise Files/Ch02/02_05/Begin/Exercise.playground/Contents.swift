/*:
# Chapter 2.5 - Subjects (Begin)
A Subject is considered a special type of Publisher, conforming to its own protocol, the Subject protocol. Apple defines subjects as

> A publisher that exposes a method for outside callers to publish elements.
 
 A publisher that you can use to inject values into a stream, done through one of its required methods, send(),  to commonly bridge existing imperative code with Combine.

*/

import Foundation
import Combine

//(1) Declare an Int PassthroughSubject

//(2) Attach a subscriber to the subject


//(3) Publish the value `94`, via the subject, directly


//(4) Connect subject to a publisher, and publish the value `29`


//(5) Declare amnother subject, a CurrentValueSubject, with an initial `I am a...` value cached

//(6) Attach a subscriber to the subject


//(7) Publish the value `Subject`, via the subject, directly


