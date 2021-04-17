//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Victor Kurinny on 17.04.2021.
//

import XCTest
@testable import Calculator

class Calculator {
    func calculate(_ symbols: [Symbol]) -> String? {
        var operation: Operation?
        var operands: [Int?] = [nil, nil]
        var operandIndex = 0

        for symbol in symbols {
            if let parcedOperation = Operation(symbol: symbol) {
                operation = parcedOperation
                operandIndex = 1
            } else {
                operands[operandIndex] = (operands[operandIndex] ?? 0) * 10 + symbol.rawValue
            }
        }

        if let operation = operation,
           let operand1 = operands[0],
           let operand2 = operands[1] {
            let result = operation.function(operand1, operand2)
            return "\(result)"
        } else if let operand1 = operands[0], operation == nil {
            return "\(operand1)"
        } else {
            return nil
        }
    }
}

extension Calculator {
    enum Symbol: Int {
        case _0
        case _1
        case _2
        case _3
        case _4
        case _5
        case _6
        case _7
        case _8
        case _9
        case plus
        case minus
    }

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

        init?(symbol: Symbol) {
            switch symbol {
            case .plus:
                self = .plus
            case .minus:
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

    func test_expectSameInteger_forIntegerInput() {
        expect("123", for: "123")
        expect("0", for: "0")
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
