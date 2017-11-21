//
//  StockDetailedViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockDetailedViewController: UIViewController {
    var stockResults: StockInfo? = nil
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockClose: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let stockResults = stockResults else {
            return
        }
        stockOpen.text = "Open: \(String(stockResults.open))"
        stockClose.text = "Close: \(String(stockResults.close))"
        print(stockResults.open, stockResults.close)
        setUpStockResults()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setUpStockResults()
    }
    
    func setUpStockResults() {
        if let stockResults = stockResults {
            if stockResults.close > stockResults.open {
                stockImage.image = #imageLiteral(resourceName: "thumbsUp")
                self.view.backgroundColor = UIColor.green
            }
            else {
                stockImage.image = #imageLiteral(resourceName: "thumbsDown")
                self.view.backgroundColor = UIColor.red
                
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
