//
//  main.swift
//  complex sorts
//
//  Created by Marat Khanbekov on 23.01.2021.
//

import Foundation

func makeList(_ n: Int) -> [Int] {
    return (0..<n).map { _ in .random(in: 1...20) }
}

//1. Реализовать сортировку подсчетом.
var n = 100000
var array = makeList(n)
var sortCountingComplexity = 0

func sortCounting() {
    var counter: [Int] = []
    let maxOfArray = array.max()!
    let minOfArray = array.min()!
    var sortedArray: [Int] = []
    
    for _ in minOfArray...maxOfArray+1 {
        sortCountingComplexity += 1
        counter.append(0)
    }
    
    for e in array {
        sortCountingComplexity += 1
        counter[e] += 1
    }
    
    sortCountingComplexity += 1
    for i in 0..<counter.count {
        sortCountingComplexity += 1
        if counter[i] > 0 {
            
            for _ in 1...counter[i] {
                sortCountingComplexity += 1
                sortedArray.append(i)
            }
        }
    }
}

//2. Реализовать быструю сортировку.
var sortQuickComplexity = 0
func sortQuick(lb: Int, rb: Int) {
    
    sortQuickComplexity += 1
    if lb >= rb {
        return
    }
    
    sortQuickComplexity += 1
    let pivot = array[Int((lb+rb)/2)]
    var i = lb
    var j = rb
    
    repeat {
        sortQuickComplexity += 1
        
        sortQuickComplexity += 1
        while array[i] < pivot {
            sortQuickComplexity += 1
            i += 1
        }
        sortQuickComplexity += 1
        while array[j] > pivot {
            sortQuickComplexity += 1
            j -= 1
        }
        
        sortQuickComplexity += 1
        if i <= j {
            
//            print("Before:", array)
            
            let t = array[i]
            array[i] = array[j]
            array[j] = t
            
            sortQuickComplexity += 1
            i += 1
            sortQuickComplexity += 1
            j -= 1
//            print("After:", array)
            
        }
    } while i <= j
    
    sortQuickComplexity += 1
    if lb < j {
        sortQuick(lb: lb, rb: j)
    }
    
    sortQuickComplexity += 1
    if i < rb {
        sortQuick(lb: i, rb: rb)
    }
}


n = 100
array = makeList(n)
sortCountingComplexity = 0
sortCounting()
print("# Operations in sortCounting for array with \(n) elements:", sortCountingComplexity)

array = makeList(n)
sortCountingComplexity = 0
sortQuickComplexity = 0
sortQuick(lb: 0, rb: array.count-1)
print("# Operations in sortQuick for array with \(n) elements:", sortQuickComplexity)

print("=-=-=-=-=-=-=-=-=-=-=-=-=-=")

n = 10000
array = makeList(n)
sortCountingComplexity = 0
sortCounting()
print("# Operations in sortCounting for array with \(n) elements:", sortCountingComplexity)

array = makeList(n)
sortCountingComplexity = 0
sortQuickComplexity = 0
sortQuick(lb: 0, rb: array.count-1)
print("Operations in sortQuick for array with \(n) elements:", sortQuickComplexity)

print("=-=-=-=-=-=-=-=-=-=-=-=-=-=")

n = 1000000
array = makeList(n)
sortCountingComplexity = 0
sortCounting()
print("Operations in sortCounting for array with \(n) elements:", sortCountingComplexity)

array = makeList(n)
sortCountingComplexity = 0
sortQuickComplexity = 0
sortQuick(lb: 0, rb: array.count-1)
print("Operations in sortQuick for array with \(n) elements:", sortQuickComplexity)

