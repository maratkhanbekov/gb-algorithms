import Foundation

// 4. *Реализовать алгоритм перевода из инфиксной записи арифметического выражения в постфиксную.

var infixExpression = "5*2+12/6+10-100*200+33-999/333"
var postfixExpression: String = ""
var outputStack: [String] = []
var operationStack: [String] = []

print("Инфиксная нотация: \(infixExpression)")

func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

func getOperatorPriority(for operatorCharacter: String) -> Int {
    switch operatorCharacter {
    case "+":
        return 1
    case "-":
        return 1
    case "/":
        return 2
    case "*":
        return 2
    default:
        return 0
    }
}

let infixExpressionParsed = matches(for: "[0-9]+|\\+|\\-|\\*|/", in: infixExpression)

for character in infixExpressionParsed {
    
    if let _ = Int(character) {
        outputStack.append(character)
    }
    
    else {
        if let previousOperation = operationStack.last {
            
            if getOperatorPriority(for: previousOperation) >= getOperatorPriority(for: character) {
                
                outputStack.append(operationStack.popLast()!)
                
                if let previousOperationNew = operationStack.last {
                    if getOperatorPriority(for: character) == getOperatorPriority(for: previousOperationNew) {
                        outputStack.append(operationStack.popLast()!)
                    }
                }
                
                operationStack.append(character)
                
            } else {
                operationStack.append(character)
            }
        }
        else {
            operationStack.append(character)
        }
    }
}

var newExpression: [String] = []
newExpression.append(contentsOf: outputStack)

repeat {
    newExpression.append(operationStack.popLast()!)
} while operationStack.count > 0


print("Постфиксная нотация: \(newExpression.joined(separator: " "))")


var calculationStack: [String] = []

for element in newExpression {
    if let _ = Int(element) {
        calculationStack.append(element)
    }
    else {
        
        let prevEl1 = calculationStack.popLast()!
        let prevEl2 = calculationStack.popLast()!
        
        let expression = prevEl2 + element + prevEl1
        let newElement = NSExpression(format: expression)
        calculationStack.append(String(newElement.expressionValue(with: nil, context: nil) as! Int))
    }
}

print("Результат через постфиксную нотакцию: \(calculationStack[0])")
let result = 5*2+12/6+10-100*200+33-999/333
print("Результат через стандартный расчет: \(result)")
