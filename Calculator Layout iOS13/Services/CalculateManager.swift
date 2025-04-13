import Foundation


final class CalculateManager {

    static let shared = CalculateManager()

    private init() {}

    var currentNumber: String = "0"
    var secondaryNumber: String = ""
    var currentOperation: Operations?
    var displayOperation: String = ""
    var resetNumber = false

    enum Operations {
        case plus
        case minus
        case division
        case percent
        case multiple
        case toggle
        case canceled

        var symbol: Character? {
            switch self {
                case .plus:
                    return "+"
                case .minus:
                    return "-"
                case .division:
                    return "÷"
                case .percent:
                    return "%"
                case .multiple:
                    return "×"
                case .canceled:
                    return nil
                default:
                    return nil
            }
        }

        func calculate(_ numberOne: Double, _ numberTwo: Double) -> Double {
            switch self {
                case .plus:
                    return numberOne + numberTwo
                case .minus:
                    return numberOne - numberTwo
                case .division:
                    return numberTwo != 0 ? numberOne / numberTwo : Double.nan
                case .percent:
                    return numberOne * (numberTwo / 100)
                case .multiple:
                    return numberOne * numberTwo
                case .toggle:
                    return -numberOne
                case .canceled:
                    return 0
            }
        }
    }

//    MARK: - Methods

    func reset() {
        currentNumber = "0"
        secondaryNumber = ""
        currentOperation = .canceled
        displayOperation = ""
        resetNumber = false
    }
    
    func inputNumber(_ number: String) {
        currentNumber = resetNumber ? number : (currentNumber == "0" ? number : currentNumber + number)
        resetNumber = false
    }
    
    func inputDecimal() {
        if !currentNumber.contains(".") {
            currentNumber += "."
        }
    }
    
    func setOperation(_ operations: Operations) {
        secondaryNumber = currentNumber
        currentNumber = "0"
        currentOperation = operations
        displayOperation = operations.symbol?.description ?? ""
        resetNumber = true
    }
    
    func calculateResult() {
        guard let numberOne = Double(secondaryNumber),
              let numberTwo = Double(currentNumber),
              let operation = currentOperation else { return }
        
        let result: Double = operation.calculate(numberOne, numberTwo)
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        
        let formatterOne = formatter.string(from: NSNumber(value: numberOne)) ?? String(numberOne)
        let formatterTwo = formatter.string(from: NSNumber(value: numberTwo)) ?? String(numberTwo)
        let formatterResult = formatter.string(from: NSNumber(value: result)) ?? String(result)
        
        secondaryNumber = "\(formatterOne) \(operation.symbol?.description ?? "") \(formatterTwo)"
        currentNumber = formatterResult
        currentOperation = .canceled
    }
    
    func toggleSign() {
        if let value = Int(currentNumber) {
            currentNumber = String(-value)
        }
    }
}
