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
        var operands = [0, 0]
        var operandIndex = 0

        for char in chars {
            if let parcedOperation = Operation(character: char) {
                operation = parcedOperation
                operandIndex = 1
            } else {
                let digit = Int(String(char))!
                operands[operandIndex] = operands[operandIndex] * 10 + digit
            }
        }

        if let operation = operation {
            let result = operation.function(operands[0], operands[1])
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
