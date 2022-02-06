//
//  String.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import Foundation
extension String {
    var isNumber : Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var toInt : Int {
        return Int(self) ?? -1
    }
}
