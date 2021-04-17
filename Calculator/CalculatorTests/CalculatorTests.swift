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
        let components = input.components(separatedBy: "+")
        guard components.count == 2 else {
            return nil
        }

        let x1 = Int(components[0])!
        let x2 = Int(components[1])!
        let result = x1 + x2

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

    func test_sumOfTwoIntegers() {
        expect("9999", for: "123+9876")
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
