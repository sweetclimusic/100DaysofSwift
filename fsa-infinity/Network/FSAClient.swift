//
//  FSAClient.swift
//  fsa-infinity
//
//  Created by Ben Foster on 24/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import Foundation

class FSAClient: FSAClientProtocol {
    
    private static let baseUrl = "https://api.ratings.food.gov.uk/"
    
    private var decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func getAuthorities(resultHandler: @escaping ([Authority]) -> Void) {
        let url = URL(string: FSAClient.baseUrl + "authorities/basic")!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("2", forHTTPHeaderField: "x-api-version")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                let authoritiesResponse = try self.decoder.decode(AuthoritiesResponse.self, from: data)
                DispatchQueue.main.async {
                    resultHandler(authoritiesResponse.authorities)
                }
            } catch {
                print("Error decoding response")
            }
        }

        task.resume()
    }

    func getEstablishmentByAuthority(authorityId:Int, resultHandler: @escaping ([Establishment]) -> Void){
        let url = URL(string: FSAClient.baseUrl + "establishments?localAuthorityId=2")!

        var urlRequest = URLRequest(url: url)

        urlRequest.setValue("2", forHTTPHeaderField: "x-api-version")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print(url)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            guard let data = data else { return }

            do {
                let establishments = try JSONDecoder().decode(Establishments.self, from: data)
                DispatchQueue.main.async {
                    resultHandler(establishments.establishments)
                }
            } catch {
                print("Error decoding response")
            }
        }

        task.resume()
    }
}
