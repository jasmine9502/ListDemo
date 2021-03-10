//
//  ListDemoUITests.swift
//  ListDemoUITests
//
//  Created by 张玥 on 2021/3/4.
//

import XCTest

class ListDemoUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //测试搜索
    func test_search_action() throws {
        let searchInfo:String = "test";
        let app = XCUIApplication()
        app.launch()
        sleep(1)
        // 读取searchbar
        let searchBar = app.searchFields["Search"]
        searchBar.tap()
        sleep(1)
        searchBar.typeText(searchInfo)
        sleep(1)
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
    }
    
    //测试列表刷新
    func test_refresh_action() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(1)
        // 读取 tableView 元素
        let table = app.tables.firstMatch
        //下拉刷新
        table.swipeDown()
        sleep(2)
    }
    
    //测试cell点击
    func test_tap_action() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(1)
        // 读取 tableView 元素
        let table = app.tables.firstMatch
        // 获取下标 30 的 cell
        let cell = table.cells.element(boundBy: 20)
        if table.xq_scrollToElement(element: cell) {
            // 已经找到 cell, 点击 cell
            cell.tap()
        }
        sleep(3)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    //tableView滚动
    func xq_scrollToElement(element: XCUIElement, isAutoStop: Bool = true) -> Bool {
        if self.elementType != .table {
            return false
        }
        while !element.isHittable {
            if isAutoStop {
                let lastElement = self.cells.element(boundBy: self.cells.count - 1)
                // 滚动到最后了, 那么就停下来
                if lastElement.isHittable {
                    return false
                }
            }
            self.swipeUp()
        }
        return true
    }
}
