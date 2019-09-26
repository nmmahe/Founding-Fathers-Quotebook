//
//  QuoteViewController.swift
//  Founding Fathers Quote Book
//
//  Created by Nick Mahe on 9/11/19.
//  Copyright © 2019 Nick Mahe. All rights reserved.
//

import UIKit
import WebKit

class QuoteViewController : UIViewController {
    
    //Constants
    private struct Storyboard{
        static let quoteOfTheDayTitle = "Quote of the Day"
    }
    
    //Properties
    var currentQuoteIndex = 0
    var quotes: [Quote]!
    var topic: String?
    //Outlets
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    private func chooseQuoteOfTheDay(){
        let formatter = DateFormatter()
        
        formatter.dateFormat = "DDD"
        
        if let dayInYear = Int(formatter.string(from: Date())){
            currentQuoteIndex = dayInYear % QuoteDeck.sharedInstance.quotes.count
        }
    }
    
    private func configure(){
        
        if let currentTopic = topic{
            currentQuoteIndex = 0
            quotes = QuoteDeck.sharedInstance.quotes(for: currentTopic)
            title = "\(currentTopic.capitalized) \(currentQuoteIndex + 1) of \(quotes.count)"
        }
        
        else{
            quotes = QuoteDeck.sharedInstance.quotes
            chooseQuoteOfTheDay()
            title = Storyboard.quoteOfTheDayTitle
        }
        
        updateUI()
    }
    
    private func updateUI(){
        let currentQuote = quotes[currentQuoteIndex]
        webView.loadHTMLString(currentQuote.html, baseURL : nil)
    }
    @IBAction func exitModalScene(_ segue: UIStoryboardSegue){
        //In this case, there is nothing to do, but we need a target
        topic = nil
        configure()
    }
    @IBAction func showTopicQuotes(_ segue: UIStoryboardSegue){
        configure()
    }
}
