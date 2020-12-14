//
//  TransactionModel.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//  Model of the JSON from http://www.mocky.io/v2/5b36325b340000f60cf88903

import Foundation

// MARK: - Transactions
struct Transactions: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, date, datumDescription, category: String
    let currency: Currency
    let amount: Amount
    let product: Product

    enum CodingKeys: String, CodingKey {
        case id, date
        case datumDescription = "description"
        case category, currency, amount, product
    }
}

// MARK: - Amount
struct Amount: Codable {
    let value: Double
    let currencyISO: Currency

    enum CodingKeys: String, CodingKey {
        case value
        case currencyISO = "currency_iso"
    }
}

enum Currency: String, Codable {
    case gbp = "GBP"
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: Title
    let icon: String
}

enum Title: String, Codable {
    case lloydsBank = "Lloyds Bank"
}
