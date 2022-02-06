//
//  RateStatus.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//

import Foundation

enum RateStatus : String {
    case success = "Let's celebrate you've rate the article successfully "
    case invalidRange = "Dear you should enter a value between 1 and 5"
    case invalidValue = "The entered value is invalid please enter a value between 1 ~ 5"
}
