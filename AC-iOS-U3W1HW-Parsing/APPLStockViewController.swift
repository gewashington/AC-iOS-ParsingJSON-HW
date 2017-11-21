//
//  APPLStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//
//VC
//A table view
//The table view should list each stock price in order from oldest to newest. Each table view cell should contain the date and the opening stock price. Feel free to use a default TableViewCell (e.g you don't need to create you own subclass).
//
//The table view should also have sections. Every month and year should have its own section. The title for the section should display the month and year as well as the average for all stock opening prices that month.



import UIKit

class APPLStockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var stockTableView: UITableView!
    
    var stocks = [StockInfo]()
    var sectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.delegate = self
        stockTableView.dataSource = self
        self.navigationItem.title = "Apple Stock History"
        loadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksInSections(section).count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section] + "  |  Average: " + averageOpenInSection(section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocksInSections(indexPath.section)[indexPath.row]
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text =  String(stock.open)
        
        
        return cell
    }
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: url) {
                //sort data here using similar idea:
                if let stocks = StockInfo.getStocks(from: data) {
                    self.stocks = stocks
                    getSectionTitles()
                }
            }
        }
        
    }
    
    func stocksInSections(_ section: Int) -> [StockInfo] {
        return stocks.filter{$0.sectionName == sectionTitles[section]}
    }
    
    
    func averageOpenInSection(_ section: Int) -> String {
        let stockListForMonth = stocksInSections(section)
        let justTheOpens: [Double] = stockListForMonth.map { $0.open }
        let openTotal: Double = justTheOpens.reduce(0, +)
        let average = openTotal / Double(justTheOpens.count)
        return String(format: "$%.2f", average)
    }
    
    
    func getSectionTitles() {
        for stock in stocks {
            //sort stocks by date using this:
            if !sectionTitles.contains(stock.sectionName) {
                sectionTitles.append(stock.sectionName)
                
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? StockDetailedViewController,
            let stockCell = sender as? UITableViewCell,
            let cellIndexPath = stockTableView.indexPath(for: stockCell) else {return }
        let stocksInThisSection = stocksInSections(cellIndexPath.section)
        let currentStock = stocksInThisSection[cellIndexPath.row]
        destination.stockResults = currentStock
        
    }
}
