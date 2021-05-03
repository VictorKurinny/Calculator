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
        let elements = parse(symbols: symbols)
        var integersStack = [Int]()
        var operationsStack = [Operation]()

        let popOperations = { (priority: Int) -> Bool in
            while let operation = operationsStack.last,
                  operation.priority >= priority {
                operationsStack.removeLast()
                if let operand2 = integersStack.popLast(),
                   let operand1 = integersStack.popLast() {
                    let result = operation.function(operand1, operand2)
                    integersStack.append(result)
                } else {
                    return false
                }
            }
            return true
        }

        for element in elements {
            switch element {
            case let .integer(value):
                integersStack.append(value)
            case let .operation(operation):
                if !popOperations(operation.priority) {
                    return nil
                }
                operationsStack.append(operation)
            }
        }

        if !popOperations(0) {
            return nil
        }

        if integersStack.count == 1,
           let result = integersStack.first {
            return "\(result)"
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

        var priority: Int {
            switch self {
            case .plus, .minus:
                return 1
            case .multiply:
                return 2
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

    private enum InputElement {
        case integer(Int)
        case operation(Operation)
    }
}

extension Calculator {
    private func parse(symbols: [Symbol]) -> [InputElement] {
        var result = [InputElement]()

        for symbol in symbols {
            if let operation = Operation(symbol: symbol) {
                result.append(.operation(operation))
            } else {
                let digit = symbol.rawValue

                if case let .integer(value) = result.last {
                    result.removeLast()
                    result.append(.integer(digit + value * 10))
                } else {
                    result.append(.integer(digit))
                }
            }
        }

        return result
    }
}
