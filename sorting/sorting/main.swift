//
//  main.swift
//  sorting
//
//  Created by Marat Khanbekov on 24.12.2020.
//

import Foundation

var program = 0

print("Введите номер задания:")
if let number = Int(readLine()!) {
    program = number
}
else {
    print("Вы ввели не число")
}

// =========================
// 1. Попробовать оптимизировать пузырьковую сортировку. Сравнить количество операций сравнения оптимизированной и не оптимизированной программы. Написать функции сортировки, которые возвращают количество операций.

func standardBubbleSorting(_ array: [Int]) -> Int {
    
    let bigOComplexity = array.count*array.count
    print("Ассимптотическая сложность алгоритма не оптимизированной пузырьковой сортировки \(bigOComplexity)")
    
    var operations = 0
    
    var _array = array
    
    let rightMargin = _array.count - 2
    
    for _ in 0..._array.count - 1 {
        
        for i in 0...rightMargin {
            
            operations += 1
            if _array[i] > _array[i+1] {
                let _temp = _array[i]
                _array[i] = _array[i+1]
                _array[i+1] = _temp
            }
        }
    }
    return operations
}

func optimizedBubbleSorting(_ array: [Int]) -> Int {
    
    let bigOComplexity = (array.count-1)*array.count/2
    print("Ассимптотическая сложность алгоритма оптимизированной пузырьковой сортировки \(bigOComplexity)")
    
    var operations = 0
    
    var _array = array
    
    for i in 0..._array.count - 1 {
        
        let rightMargin = _array.count-2-i
        
        if rightMargin < 1 {
            continue
        }
        
        for j in 0...rightMargin {
            
            operations += 1
            if _array[j] > _array[j+1] {
                let _temp = _array[j]
                _array[j] = _array[j+1]
                _array[j+1] = _temp
                
            }
        }
        
    }
    return operations
}


typealias sortingCompexityEstimator = (_ : [Int]) -> Int

func sortingAlgorithmsComparasion(arraysForTest: [[Int]], algorithms: [sortingCompexityEstimator]) {
    var algoNumber = 1
    for algo in algorithms {
        print("Алгоритм \(algoNumber) =========")
        var arrayNumber = 0
        var totalNumberOfOperations = 0
        for array in arraysForTest {
            let result = algo(array)
            arrayNumber += 1
            totalNumberOfOperations += result
        }
        print("Среднее кол-во операций алгоритма \(algoNumber): \(totalNumberOfOperations/arrayNumber)")
        
        algoNumber += 1
    }
}
if program == 1 {
    sortingAlgorithmsComparasion(arraysForTest: [
        [1, 3, 6, 5, 10, 1, 2, 4, 8, 7, 9, 7, 6, 5, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 2, 6, 5, 10, 1, 2, 4, 8, 7, 9, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 1, 3, 6, 5, 10, 1, 2, 4, 8, 7, 9, 7, 6, 5, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 2, 6, 5, 10, 1, 2, 4, 8, 7, 9, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 1, 3, 6, 5, 10, 1, 2, 4, 8, 7, 9, 7, 6, 5, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 2, 6, 5, 10, 1, 2, 4, 8, 7, 9, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1]
    ],
    algorithms: [standardBubbleSorting(_:),
                 optimizedBubbleSorting(_:)
    ])
    
}


// =========================
// 2. *Реализовать шейкерную сортировку.

func coctailSorting(_ array: [Int]) -> Int {
    
    let bigOComplexity = (array.count-1)*array.count/2
    print("Ассимптотическая сложность алгоритма шейкерной сортировки \(bigOComplexity)")
    
    
    var operations = 0
    
    var _array = array
    var leftMargin = 0
    var rightMargin = _array.count-1
    var round = 0
    
    repeat {
        if round % 2 > 0 {
            
            for i in stride(from: rightMargin, to: leftMargin, by: -1) {
                
                operations += 1
                if _array[i] < _array[i-1] {
                    
                    let temp = _array[i]
                    _array[i] = _array[i-1]
                    _array[i-1] = temp
                }
            }
            rightMargin -= 1
        }
        
        else {
            for i in leftMargin...rightMargin-1 {
                
                operations += 1
                if _array[i] > _array[i+1] {
                    
                    let temp = _array[i]
                    _array[i] = _array[i+1]
                    _array[i+1] = temp
                }
            }
            leftMargin += 1
        }
        round += 1
        
    } while leftMargin < rightMargin
    return operations
}

if program == 2 {
    print("Шейкерная сортировка сделала \(coctailSorting([3, 2, 1, 3, 2, 1, 4, 5, 6, 10, 1])) операций")
}


// 3. Реализовать бинарный алгоритм поиска в виде функции, которой передается отсортированный массив. Функция возвращает индекс найденного элемента или -1, если элемент не найден.
func binarySearch(array: [Int], element: Int, subset: Int = 0) -> Int {
    let m = Int(array.count/2)
    
    if element == array[m] {
        return subset + m
    }
    
    if array.count > 0 && m > 0 {
        
        if element > array[m] {
            return binarySearch(array: Array(array[m+1...array.count-1]), element: element, subset: subset + m + 1)
        }
        else {
            return binarySearch(array: Array(array[0..<m]), element: element, subset: subset)
        }
    }
    
    else {
        return -1
    }
}

if program == 3 {
    print("Алгоритм бинарного поиска")
    print("Должно быть: 0 / Ответ алгоритма: \(binarySearch(array: [1, 2], element: 1))")
    print("Должно быть: 2 / Ответ алгоритма: \(binarySearch(array: [1, 4, 5, 6, 8, 9], element: 5))")
    print("Должно быть: 5 / Ответ алгоритма: \(binarySearch(array: [1, 2, 4, 7, 8, 10], element: 10))")
    print("Должно быть: 9 / Ответ алгоритма: \(binarySearch(array: [1, 2, 4, 7, 8, 10, 11, 14, 16, 20], element: 20))")
}

//4. *Подсчитать количество операций для каждой из сортировок и сравнить его с асимптотической сложностью алгоритма.

if program == 4 {
    sortingAlgorithmsComparasion(arraysForTest: [
        [1, 3, 6, 5, 10, 1, 2, 4, 8, 7, 9, 7, 6, 5, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 2, 6, 5, 10, 1, 2, 4, 8, 7, 9, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 1, 3, 6, 5, 10, 1, 2, 4, 8, 7, 9, 7, 6, 5, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 2, 6, 5, 10, 1, 2, 4, 8, 7, 9, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 1, 3, 6, 5, 10, 1, 2, 4, 8, 7, 9, 7, 6, 5, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1, 2, 6, 5, 10, 1, 2, 4, 8, 7, 9, 4, 8, 7, 9, 7, 6, 5, 4, 3, 6, 5, 10, 1]
    ],
    algorithms: [standardBubbleSorting(_:),
                 optimizedBubbleSorting(_:),
                 coctailSorting(_:)])
}
