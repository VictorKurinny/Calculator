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
        var operation: Operation?
        var operands: [Int?] = [nil, nil]
        var operandIndex = 0

        for char in chars {
            if let parcedOperation = Operation(character: char) {
                operation = parcedOperation
                operandIndex = 1
            } else {
                let digit = Int(String(char))!
                operands[operandIndex] = (operands[operandIndex] ?? 0) * 10 + digit
            }
        }

        if let operation = operation,
           let operand1 = operands[0],
           let operand2 = operands[1] {
            let result = operation.function(operand1, operand2)
            return "\(result)"
        } else {
            return nil
        }
    }
}

extension Calculator {
    private enum Operation {
        case plus
        case minus

        var function: (Int, Int) -> Int {
            switch self {
            case .plus:
                return { $0 + $1 }
            case .minus:
                return { $0 - $1 }
            }
        }

        init?(character: Character) {
            switch character {
            case "+":
                self = .plus
            case "-":
                self = .minus
            default:
                return nil
            }
        }
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

    func test_substractionOfTwoIntegers() {
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
