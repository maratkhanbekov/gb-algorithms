import Foundation

var exercise = 0

print("Введите номер упраженения")
if let numberOfExercise = Int(readLine()!) {
    exercise = numberOfExercise
}
else {
    print("Надо было ввести число")
}



//3. Исполнитель Калькулятор преобразует целое число, записанное на экране. У исполнителя две команды, каждой команде присвоен номер:
//
//Прибавь 1
//Умножь на 2
//Первая команда увеличивает число на экране на 1, вторая увеличивает это число в 2 раза. Сколько существует программ, которые число 3 преобразуют в число 20?
//а) с использованием массива;
//б) с использованием рекурсии.
//Реализовать меню с выбором способа заполнения массива: из файла, случайными числами, с клавиатуры.

if exercise == 3 {
    
    print("Задание 3")
    print("Введите 1 для расчета без рекурсии")
    print("Введите 2 для расчета с рекурсией")
    
    if let programm = Int(readLine()!) {
        if programm == 1 {
            calc1()
        } else {
            calc2()
        }
    }
}

func calc1() {
    let mutliRuleValue = 2
    
    let inputNumber1: Int = 3
    let inputNumber2: Int = 20
    
    let multiRuleUpperBound = Int(ceil((log(CGFloat(inputNumber2)/CGFloat(inputNumber1))/log(2))))
    var arrayOfEquations: [String] = []
    
    for i in 1...inputNumber2 {
        
        if multiRuleUpperBound < 1 {
            continue
        }
        
        for j in 0...multiRuleUpperBound {
            
            let currentMultiRuleValue = powFunc(mutliRuleValue, j+1)
            
            // +
            if inputNumber1 + i == inputNumber2 {
                let equation = "\(inputNumber1)+\(i)"
                arrayOfEquations.append(equation)
            }
            
            // *
            if inputNumber1 * currentMultiRuleValue == inputNumber2 {
                let equation = "\(inputNumber1)*\(currentMultiRuleValue)"
                arrayOfEquations.append(equation)
            }
            
            // + *
            if (inputNumber1 + i) * currentMultiRuleValue == inputNumber2 {
                let equation = "(\(inputNumber1)+\(i))*\(currentMultiRuleValue)"
                arrayOfEquations.append(equation)
            }
            // + * +
            
            if (inputNumber1 + i) * currentMultiRuleValue + i == inputNumber2 {
                let equation = "(\(inputNumber1)+\(i))*\(currentMultiRuleValue)+\(i)"
                arrayOfEquations.append(equation)
            }
            
            // + * + *
            if ((inputNumber1 + i) * currentMultiRuleValue + i) * currentMultiRuleValue == inputNumber2 {
                let equation = "((\(inputNumber1)+\(i))*\(currentMultiRuleValue)\(i))*\(currentMultiRuleValue)"
                arrayOfEquations.append(equation)
            }
            
            // + * + * + END PART I
            if ((inputNumber1 + i) * currentMultiRuleValue + i) * currentMultiRuleValue + i == inputNumber2 {
                let equation = "((\(inputNumber1)+\(i))*\(currentMultiRuleValue)+\(i))*\(currentMultiRuleValue)+\(i)"
                arrayOfEquations.append(equation)
            }
            
            // * +
            if inputNumber1 * currentMultiRuleValue + i == inputNumber2 {
                let equation = "\(inputNumber1)*\(currentMultiRuleValue)+\(i)"
                arrayOfEquations.append(equation)
            }
            
            // * + *
            if (inputNumber1 * currentMultiRuleValue + i) * currentMultiRuleValue == inputNumber2 {
                let equation = "(\(inputNumber1)*\(currentMultiRuleValue)+\(i))*\(currentMultiRuleValue)"
                arrayOfEquations.append(equation)
            }
            

            // * + * +
            if (inputNumber1 * currentMultiRuleValue + i) * currentMultiRuleValue + i == inputNumber2 {
                let equation = "(\(inputNumber1)*\(currentMultiRuleValue)+\(i))*\(currentMultiRuleValue)+\(i)"
                arrayOfEquations.append(equation)
            }
        }
    }
    print("Количество подпрограмм: \(arrayOfEquations.count):")
    print(arrayOfEquations)
    print("Полное кол-во посчитать не удалось")
}


func calc2() {
    print("Задание 3")
    print("Введите число")
   
    let numberOfSteps = stepCombinationsCounter(v: 3)
    print("Количество подпрограмм: \(numberOfSteps):")

}
func stepCombinationsCounter(v: Int) -> Int {
    
    if v < 20 {
        
        let afterStepAdd = v + 1
        let afterStepMulti = v * 2
        
        if afterStepMulti == 20 {
            return 1 + stepCombinationsCounter(v: afterStepAdd)
        }
        
        if afterStepAdd == 20 {
            return 1
        }
        
        return stepCombinationsCounter(v: afterStepAdd) + stepCombinationsCounter(v: afterStepMulti)
    }
    else {
        return 0
    }
}


// Реализовать функцию возведения числа a в степень b:
//a. Без рекурсии.
//b. Рекурсивно.
//c. *Рекурсивно, используя свойство чётности степени.

if exercise == 2 {
    print("Задание 2")
    print("Введите число a:")
    if let inputNumberA = Int(readLine()!) {
        print("Введите число b:")
        if let inputNumbeB = Int(readLine()!) {
            let result = powFunc(inputNumberA, inputNumbeB)
            print(result)
        }
    }
}

func powFunc(_ a: Int, _ b: Int) -> Int {
    
    switch b {
    case ...0:
        return (1/a) * powFunc(a, b + 1)
    case 0:
        return 1
    case 1:
        return a
    case 0...1:
        return 1
    case 1...:
        return a*powFunc(a, b - 1)
        
    default:
        return 1
    }
}

// 1. Реализовать функцию перевода чисел из десятичной системы в двоичную, используя рекурсию.
if exercise == 1 {
    print("Задание 1")
    print("Введите число:")
    if let inputNumber = Int(readLine()!) {
        let newNumber = from10to2(number: inputNumber)
        print(newNumber)
    }
}

func from10to2(number: Int, result: [Int] = []) -> Int {
    let reminder = number % 2
    var _result = result
    
    _result.append(reminder)
    
    if number > 1 {
        let _number = Int(number/2)
        return from10to2(number: _number, result: _result)
    }
    else {
        var outputNumber = 0
        for i in 0..._result.count-1 {
            outputNumber = outputNumber + _result[i]*Int(pow(Double(10), Double(i)))
        }
        return outputNumber
    }
}
