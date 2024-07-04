//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Sümeyra Demirtaş on 4.07.2024.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
