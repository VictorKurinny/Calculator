//
//  Calculator.swift
//  Calculator
//
//  Created by Victor Kurinny on 03.05.2021.
//

import Foundation

public class Calculator {
    public init() {}

    public func calculate(_ symbols: [Symbol]) -> String? {
        var operation: Operation?
        var operands: [Int?] = [nil, nil]
        var operandIndex = 0

        for symbol in symbols {
            if let parsedOperation = Operation(symbol: symbol) {
                operation = parsedOperation
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
    public enum Symbol: Int {
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
        case multiply
    }

    private enum Operation {
        case plus
        case minus
        case multiply

        var function: (Int, Int) -> Int {
            switch self {
            case .plus:
                return { $0 + $1 }
            case .minus:
                return { $0 - $1 }
            case .multiply:
                return { $0 * $1 }
            }
        }

        init?(symbol: Symbol) {
            switch symbol {
            case .plus:
                self = .plus
            case .minus:
                self = .minus
            case .multiply:
                self = .multiply
            default:
                return nil
            }
        }
    }
}
