//
//  TransactionItemViewModel.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//

import Foundation
import UIKit

protocol ListDownloadCompletionDelegate {
    func listDownLoadCompleted(_ listItems: [TransactionItemModel])
}


class TransactionItemViewModel {
    var systemUrl: String = "https://www.mocky.io/v2/5b36325b340000f60cf88903"
    var transactionList: [TransactionItemModel] = []
    var completionDelegate: ListDownloadCompletionDelegate!
    fileprivate var transactionItems: Transactions?
    fileprivate var dateFormatter: DateFormatter = DateFormatter()
    fileprivate var numberFormatter: NumberFormatter = NumberFormatter()
    ///init fetches data from a url and sends the completed downloaded data onto the delegate for processing.
    ///The date and number formatter base on the JSON data are also initialized
    init() {
        nsURLSessionGetRequest(url: systemUrl, completion: { success, transactionList in
            if success {
                self.completionDelegate.listDownLoadCompleted(transactionList)
            }
        })
        //setup formatting rules
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy-mm-dd"
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        
    }
}
let cache = NSCache<NSString, UIImage>()
extension TransactionItemViewModel {
    
    /// Use the shared URLSession dataTask to pull the transaction data down and decode base on TransactionJsonModel
    /// - Parameter url:String the string url to GET request mock transactions
    ///             completion: @escaping (Bool,[TransactionItemModel]) after downloading of json completion function will process the list of TransactionItemModel
    fileprivate func nsURLSessionGetRequest(url: String, completion: @escaping(Bool, [TransactionItemModel]) -> Void ) {
        guard let url = URL(string: url) else {
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, error == nil {
                //decode the json in the closure
                if let decodedTransactions = try? JSONDecoder().decode(Transactions.self, from: data) {
                    DispatchQueue.main.async {
                        self.transactionItems = decodedTransactions
                        completion(true,self.generateTransactionsList())
                    }
                }
            } else {
                completion(false,[])
            }
        }.resume()
    }
    
    /// Generate Transaction List transforms the JSON to appropriate types to a TransactionItem to be displayed in a UICollectionView
    func generateTransactionsList() -> [TransactionItemModel] {
        //verify transactionItems not nil and has data
        guard let transactionItems = self.transactionItems, !transactionItems.data.isEmpty else { return [] }
        transactionList.removeAll()
        for item in transactionItems.data {
            //use cached logo or downloadImage when retrieving from URL
            let currencySymbol = LanguageUtility.getLocaleIdentifierForCurrencyISO(item.currency.rawValue)!
            numberFormatter.locale = Locale(identifier: currencySymbol)
            let amount = numberFormatter.string(from: item.amount.value as NSNumber) ?? numberFormatter.string(from: 0)!
            let date = dateFormatter.date(from: item.date)!
            //use the cached version if already downloaded or placeholder image
            // populate list of transactions
            var transaction = TransactionItemModel(
                image: UIImage(systemName: "rectangle")!,
                amount: amount,
                id: item.id,
                datumDescription: item.datumDescription,
                category: item.category,
                date: date,
                imageUrl: item.product.icon)
            
            if let cachedImage: UIImage = cache.object(forKey: item.product.icon as NSString) {
                transaction.image = cachedImage
            }
            transactionList.append(transaction)
        
        }
        return transactionList
    }
}
