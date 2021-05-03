//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Victor Kurinny on 17.04.2021.
//

import XCTest
import Calculator

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

    func test_subtractionOfTwoIntegers() {
        expect("-3", for: "12-15")
    }

    func test_returnsError_whenFirstOperandIsEmpty() {
        expect(nil, for: "+34")
    }

    func test_returnsError_whenSecondOperandIsEmpty() {
        expect(nil, for: "35+")
    }

    func test_returnsError_whenBothOperandsAreEmpty() {
        expect(nil, for: "-")
    }

    func test_zeroMinusZeroEqualZero() {
        expect("0", for: "0-0")
    }

    func test_expectSameInteger_forIntegerInput() {
        expect("123", for: "123")
        expect("0", for: "0")
    }

    func test_multiplicationOfTwoIntegers() {
        expect("36", for: "3*12")
    }

    func test_threeOperands() {
        expect("7", for: "1+2*3")
        expect("5", for: "1*2+3")
        expect("6", for: "1+2+3")
        expect("-4", for: "1-2-3")
        expect("0", for: "1+2-3")
        expect("2", for: "1-2+3")
        expect("2", for: "1-2+3")
        expect("6", for: "1*2*3")
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

        let symbols: [Calculator.Symbol] = input.map {
            switch $0 {
            case "0":
                return ._0
            case "1":
                return ._1
            case "2":
                return ._2
            case "3":
                return ._3
            case "4":
                return ._4
            case "5":
                return ._5
            case "6":
                return ._6
            case "7":
                return ._7
            case "8":
                return ._8
            case "9":
                return ._9
            case "+":
                return .plus
            case "-":
                return .minus
            case "*":
                return .multiply
            default:
                preconditionFailure("Unsupported symbol \($0)")
            }
        }

        let result = sut.calculate(symbols)

        XCTAssertEqual(
            result,
            expectedResult,
            "Expected \(String(describing: expectedResult)), got \(String(describing: result)) instead",
            file: file,
            line: line
        )
    }
}
