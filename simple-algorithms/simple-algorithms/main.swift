import Foundation

var program = 0

print("Введите номер программы:")
if let number = Int(readLine()!) {
    program = number
}
else {
    print("Вы ввели не число")
}

// 10. Дано целое число N (> 0). С помощью операций деления нацело и взятия остатка от деления определить, имеются ли в записи числа N нечетные цифры. Если имеются, то вывести True, если нет — вывести False.
if program == 10 {
    print("Введите число")
    if let input = Int(readLine()!) {
        var answer = "В записи числа все цифры четные"
        var divisor = 1
        var quotient = 1
        
        repeat {
            quotient = Int(input/divisor)
            let reminder = quotient % 2
            if (reminder > 0) {
                answer = "В записи числа имеются нечетные цифры"
                break
            }
            divisor = divisor*10
        } while quotient > 0
        print(answer)
    }
    else {
        print("Введено не число")
    }
}


// 11. С клавиатуры вводятся числа, пока не будет введен 0. Подсчитать среднее арифметическое всех положительных четных чисел, оканчивающихся на 8.
if program == 11 {
    var avgResult = 0
    var totalSum = 0
    var counter = 0
    
    repeat {
        print("Введите число")
        if let number = Int(readLine()!) {
            if number == 0 {
                print("Введен 0. Программа остановлена. Средне арифметическое \(avgResult)")
                break
            }
            
            if (number > 0) && (number % 10 == 8) {
                totalSum += number
                counter += 1
                avgResult = totalSum/counter
            }
            
        }
        else {
            print("Вы не ввели число. Программа остановлена. Средне арифметическое \(avgResult)")
            break
        }
    }
    while true
}


// 12. Написать функцию нахождения максимального из трех чисел.
func maxOfThree() {
    print("Введите 3 числа через пробел:")
    if let input = readLine() {
        let maxNumber = input.components(separatedBy: " ").map{Int($0)!}.max()
        print("Максимальное число \(maxNumber!)")
    }
    else {
        print("Вы ничего не ввели")
    }
}

if program == 12 {
    maxOfThree()
}

// 13. Написать функцию, генерирующую случайное число от 1 до 100.
// а) с использованием стандартной функции rand()
// б) без использования стандартной функции rand()

if program == 13 {
    let date = Date()
    let calendar = Calendar.current
    
    let i = calendar.component(.second, from: date)
    if i % 2 == 0 {
        let random = (1245 * i + 54321) % 100
        print("Случайно сгенерированное число вручную: \(random)")
    }
    else {
        let random = Int.random(in: 0...100)
        print("Случайно сгенерированное число через встороенную функцию: \(random)")
    }
}




// 14. * Автоморфные числа. Натуральное число называется автоморфным, если оно равно последним цифрам своего квадрата. Например, 25 \ :sup: `2` = 625. Напишите программу, которая вводит натуральное число N и выводит на экран все автоморфные числа, не превосходящие N.

if program == 14 {
    
    print("Введите число")
    if let input = Int(readLine()!) {
        
        var arrayOfAutoMorphyNumbers: [Int] = []
        
        for i in 0...input where i >= 5 {
            if checkAutoMorphy(i) {
                arrayOfAutoMorphyNumbers.append(i)
            }
        }
        
        if arrayOfAutoMorphyNumbers.count > 0 {
            print(arrayOfAutoMorphyNumbers)
        }
        else {
            print("Автоморфных чисел не найдено")
        }
    }
}

func checkAutoMorphy(_ i: Int) -> Bool {
    
    var reminderOfNumber: Int
    var reminderOfSquared: Int
    var number = i
    var squaredNumber = i*i
    var isAutoMorphy = true
    
    repeat {
        reminderOfNumber = Int(number % 10)
        reminderOfSquared = Int(squaredNumber % 10)
        
        if reminderOfNumber != reminderOfSquared {
            isAutoMorphy = false
            break
        }
        
        number /= 10
        squaredNumber /= 10
        
    } while number > 0
    
    return isAutoMorphy
}


