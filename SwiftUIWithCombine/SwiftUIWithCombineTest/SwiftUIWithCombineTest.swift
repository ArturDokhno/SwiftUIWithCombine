//
//  SwiftUIWithCombineTest.swift
//  SwiftUIWithCombineTests
//
//  Created by Артур Дохно on 11.07.2022.
//

import XCTest
import Combine
@testable import SwiftUIWithCombine

class SwiftUICombineSlotMachineYSTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var viewModel: SlotViewModel!
    
    override func setUpWithError() throws {
        viewModel = SlotViewModel()
    }
    
    override func tearDownWithError() throws {
        cancellables = []
    }
    
    func testButtonTextChanged() {
        let expected = "Play!"
        let expectation = XCTestExpectation()
        
        viewModel
            .$buttonText
            .dropFirst()
            .sink { value in XCTAssertEqual(value, expected); expectation.fulfill() }
            .store(in: &cancellables)
        
        viewModel.running = false
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWin() {
        let expected = "You victory!"
        let expectation = XCTestExpectation()
        
        viewModel
            .$titleText
            .dropFirst()
            .sink { value in XCTAssertEqual(value, expected); expectation.fulfill() }
            .store(in: &cancellables)
        
        viewModel.slot1Emoji = "🍋"
        viewModel.slot2Emoji = "🍋"
        viewModel.slot3Emoji = "🍋"
        
        viewModel.running = false
        viewModel.gameStarted = true
        
        wait(for: [expectation], timeout: 1)
    }
}
