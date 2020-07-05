//
//  Jet2MvvmDemoTests.swift
//  Jet2MvvmDemoTests
//
//  Created by Ankush on 03/07/20.
//  Copyright © 2020 Ankush. All rights reserved.
//

import XCTest
@testable import Jet2MvvmDemo

class Jet2MvvmDemoTests: XCTestCase {
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testArticleViewModel() {
        
        let article = Articles(id: "1", createdAt: "2020-04-17T12:13:44.575Z", content: "calculating the program ", comments: 111, likes: 1111, user: [], media: [])
        let articleViewModel = ArticleViewModel(article: article)
        
        XCTAssertEqual(String(article.comments), articleViewModel.comment)
        XCTAssertEqual(String(article.likes), articleViewModel.likes)
       
    }
    
    func testMainViewConroller()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ArticleDetailViewController
        
        XCTAssertNotNil(vc.monitor , "can not be nil")
        XCTAssertEqual(vc.defaultPageNumber , 1)
        
    }

}
