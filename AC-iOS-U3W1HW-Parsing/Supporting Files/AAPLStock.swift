//
//  AAPLStock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class StockInfo {
    let date: String
    let open: Double
    let label: String //use for section titles and label?
    let close: Double //Use for averages?
    let low: Double
    let high: Double
    init(date: String, open:Double, label: String, close: Double, low: Double, high: Double) {
        self.date = date
        self.open = open
        self.label = label
        self.close = close
        self.low = low
        self.high = high
    }
    
    
    
    var sectionName: String {
        enum Month: Int {
            case January = 01, February, March, April, May, June, July, August, September, October, November, December
        }
        let year = date.prefix(4)
        let startOfMonthString = date.index(date.startIndex, offsetBy: 5)
        let endOfMonthString = date.index(date.endIndex, offsetBy: -3)
        var range = startOfMonthString..<endOfMonthString
        let month = Int(date[range])
        return "\(Month.init(rawValue: month!)!) \(year)"
        
        
    }
    
    
    
    static func getStocks(from data: Data) -> [StockInfo]? {
        var stocks = [StockInfo]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let jsonDict = json as? [[String:Any]] {
                for stockDict in jsonDict {
                    guard  let date = stockDict["date"] as? String,
                        let open = stockDict["open"] as? Double,
                        let label = stockDict["label"] as? String,
                        let close = stockDict["close"] as? Double,
                        let low = stockDict["low"] as? Double,
                        let high = stockDict["high"] as? Double else {
                            return nil
                    }
                    let stock = StockInfo(date: date, open: open, label: label, close: close, low: low, high: high)
                    stocks.append(stock)
                    
                }
            }
        }
        catch let error {
            print(error)
        }
        
        return stocks
    }
    
    
}

/*
 VC
 A table view
 The table view should list each stock price in order from oldest to newest. Each table view cell should contain the date and the opening stock price. Feel free to use a default TableViewCell (e.g you don't need to create you own subclass).
 
 The table view should also have sections. Every month and year should have its own section. The title for the section should display the month and year as well as the average for all stock opening prices that month.
 
 Detail VC
 A UIImage
 A label to represent the date
 Two labels to represent the opening and closing prices
 If the stock price went up that day, set the background color to green and make the image a thumbs up.
 If the stock price went down that day, set the background color to red and make the image a thumbs down.
 */


/*
 [{"date":"2015-11-11","open":116.37,"high":117.42,"low":115.21,"close":116.11,"volume":45217971,"unadjustedVolume":45217971,"change":-0.66,"changePercent":-0.565,"vwap":116.3069,"label":"Nov 11, 15","changeOverTime":0},{"date":"2015-11-12","open":116.26,"high":116.82,"low":115.65,"close":115.72,"volume":32525579,"unadjustedVolume":32525579,"change":-0.39,"changePercent":-0.336,"vwap":116.0415,"label":"Nov 12, 15","changeOverTime":-0.003358883817070025}]
 */



//Parse Data
//Main VC
//sort prices by date using sort function in VC.
//Use table view cell - Basic \(label): \(open)
//Use date to for sections. Can you sort by Dates using NSDateFormatter? Nov 12
//Detail VC
//image = asset image. Use conditional for image?
//dateLabel = date
//openLabel = open
//closeLabel = close
//


