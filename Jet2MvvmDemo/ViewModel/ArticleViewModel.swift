//
//  ArticleViewModel.swift
//  Jet2MvvmDemo
//
//  Created by Ankush on 03/07/20.
//  Copyright © 2020 Ankush. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    
    let user: [User]
    let media: [Media]
    let likes: String
    let comment: String
    let content: String
    let lastSeen : String


    // Dependency Injection (DI)
    init(article: Articles) {
        self.user = article.user
        self.media = article.media
        self.likes = article.likes.roundedWithAbbreviations
        self.comment = article.comments.roundedWithAbbreviations
        self.content = article.content
        self.lastSeen = Date.timeAgoSinceDate(article.createdAt.toDate())()
    }
    

}
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

extension Date {

    func timeAgoSinceDate() -> String {

        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year" : "\(interval)" + " " + "years"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month" : "\(interval)" + " " + "months"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day" : "\(interval)" + " " + "days"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour" : "\(interval)" + " " + "hours"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute" : "\(interval)" + " " + "minutes"
        }

        return "a moment ago"
    }
}
extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}

