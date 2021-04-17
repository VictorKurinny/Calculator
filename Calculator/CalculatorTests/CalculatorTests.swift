//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Victor Kurinny on 17.04.2021.
//

import XCTest
@testable import Calculator

class Calculator {
    func calculate(_ input: String) -> String? {
        nil
    }
}

class CalculatorTests: XCTestCase {
    func test_returnsError_forEmptyInput() {
        let sut = Calculator()

        let result = sut.calculate("")

        XCTAssertNil(result)
    }
}
