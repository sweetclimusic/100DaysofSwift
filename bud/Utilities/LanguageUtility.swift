//
//  LanguageUtility.swift
//  bud
//
//  Created by Ashlee Muscroft on 30/11/2020.
//

import Foundation

class LanguageUtility {
    /// Returns a string local identifier, either the ORG language identifier, identified by the currency on login
    /// or the users device local identifier.
    static func getLocaleIdentifierForCurrencyISO(_ currencyISO: String) -> String? {
        let localIdentifier: String?
        //force formatting to ORG currency
        //symbol, left or right?
        switch currencyISO.lowercased(){
            case "gbp":
                // force to en_UK
                localIdentifier = Locale(identifier: "en_GB").identifier
            case "usd":
                //force to en_US
                localIdentifier = Locale(identifier: "en_US").identifier
            case "eur":
                // force to de_DE
                localIdentifier = Locale(identifier: "de_DE").identifier
            default: //left
                localIdentifier = Locale.current.identifier
        }
        return localIdentifier
    }
}
