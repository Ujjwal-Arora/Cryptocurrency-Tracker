//
//  Formatter.swift
//  Cryptocurrency Tracker
//
//  Created by Ujjwal Arora on 15/09/24.
//

import Foundation


extension Double{
    func currencyFormatter() -> String{
        return self.formatted(.currency(code: "inr").precision(.fractionLength(0...4)))
    }
    func percentageFormatter() -> String{
        return self.formatted(.number.precision(.fractionLength(2))) + "%"
    }
    func quantityFormatter() -> String{
        return self.formatted(.number.precision(.fractionLength(2...6)))
    }
}


