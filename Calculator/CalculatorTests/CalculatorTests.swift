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
        let chars = Array(input)
        guard chars.count == 3 else {
            return nil
        }

        let digit1 = Int(String(chars[0]))!
        let digit2 = Int(String(chars[2]))!
        let result = digit1 + digit2

        return "\(result)"
    }
}

class CalculatorTests: XCTestCase {
    func test_returnsError_forEmptyInput() {
        expect(nil, for: "")
    }

    func test_sumOfTwoDigits() {
        expect("3", for: "1+2")
    }
}

extension CalculatorTests {
    private func expect(
        _ expectedResult: String?,
        for input: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let sut = Calculator()

        let result = sut.calculate(input)

        XCTAssertEqual(
            result,
            expectedResult,
            "Expected \(String(describing: expectedResult)), got \(String(describing: result)) instead",
            file: file,
            line: line
        )
    }
}
