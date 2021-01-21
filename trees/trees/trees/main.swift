//
//  main.swift
//  trees
//
//  Created by Marat Khanbekov on 20.01.2021.
//

import Foundation

//1. Реализовать простейшую хэш-функцию. На вход функции подается строка, на выходе сумма кодов символов.
let symbols_codes: [String: Int] = [
    "A": 142, "B": 252, "C": 3, "D": 4636, "E": 415, "F": 64124, "G": 63447, "H": 886, "I": 912, "J": 1021, "K": 1141, "L": 311, "M": 11, "N": 14, "O": 163465, "P": 13456, "Q": 1724, "R": 184124, "S": 149, "T": 2430, "U": 3221, "V": 2122, "W": 141, "X": 24, "Y": 25, "Z": 5333
]

func getHash(for line: String) -> Int {
    var hash = 0
    var counter = 1
    for c in line {
        hash += symbols_codes[c.uppercased()]! + counter
        counter += 1
    }
    return hash
}

print("1. Перевод в хэш")
print(getHash(for: "marat")) // 53
print(getHash(for: "taram")) // 53

//2. Переписать программу, реализующее двоичное дерево поиска.
var tree = [-1, 8, 9, 15, 12, 6, 6, 12, 16, -1, -1, -1, 5, -1, -1, -1, -1, -1, -1, -1]
var expression = ""

func printTree(for root: Int) {
    
    if (tree[root] != -1) {
        
        expression += "\(tree[root])"
        
        if root*2+1 <= tree.count-1 && (tree[root*2] != -1 || tree[root*2+1] != 1) {
            
            expression += "("
            
            if tree[root*2] != -1 {
                printTree(for: root*2)
            }
            else {
                expression += "NULL"
            }
            expression += ","
            
            if tree[root*2+1] != -1 {
                printTree(for: root*2+1)
            }
            else {
                expression += "NULL"
            }
            expression += ")"
        }
    }
}


printTree(for: 1)
print(expression)

//а) Добавить в него обход дерева различными способами;

func printCLRTree(for root: Int) {
    if (tree[root] != -1) {
        print(tree[root])
        if root*2+1 <= tree.count-1 {
            if tree[root*2] != -1 {
                printCLRTree(for: root*2)
            }
            if tree[root*2+1] != -1 {
                printCLRTree(for: root*2+1)
            }
        }
    }
}
print("2а. Обход дерева")
printCLRTree(for: 1)

//б) Реализовать поиск в двоичном дереве поиска;
tree = [0, 8, 4, 10, 2, 6, -1, -1, -1, 3, -1, 7, -1, -1, -1, -1, -1, -1, -1, -1]

printTree(for: 1)
print(expression)

func searchInBinaryTree(in root: Int, for number: Int) -> Bool {
    if (tree[root] != -1) {
        if tree[root] == number {
            return true
        }
        else if number > tree[root] {
            return searchInBinaryTree(in: root*2+1, for: number)
        }
        else if number < tree[root]  {
            return searchInBinaryTree(in: root*2, for: number)
        }
    }
    return false
}

print("2б. Поиск в двоичном дереве")
print(searchInBinaryTree(in: 1, for: 4))
print(searchInBinaryTree(in: 1, for: 11))


//3. *Разработать базу данных студентов из полей “Имя”, “Возраст”, “Табельный номер” в которой использовать все знания, полученные на уроках.
//Считайте данные в двоичное дерево поиска. Реализуйте поиск по какому-нибудь полю базы данных (возраст, вес)

let database = [
    ["Ivan", 48, 1234],
    ["Mustafa", 19, 4321],
    ["George", 77, 2141],
    ["Sofia", 25, 4124],
    ["Mike", 42, 1241]
]

var database_hashed: [Int] = []

for record in database {
    let hash = getHash(for: "\(record[0])") // + Int(record[1]) + Int(record[2])
    database_hashed.append(hash)
}


func createBinaryTree(for array: [Int], level: Int = 1) {
    let len = array.count
    let rootPosition = Int(len/2)
    
    tree[level] = array[rootPosition]
    
    // Обрабатываем левую ветку
    if rootPosition > 0 {
        createBinaryTree(for: Array(array[0..<rootPosition]), level: level*2)
    }
    
    // Обрабатываем правую ветку
    if rootPosition < len - 1 {
        createBinaryTree(for: Array(array[rootPosition+1...len-1]), level: level*2+1)
    }
}

//let sortedArray = [1, 2, 3, 4, 5]
tree = [0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]

createBinaryTree(for: database_hashed)


print("4. Поиск в двоичном дереве по хэшу")
var nameForSearch = "Ivan"
print(searchInBinaryTree(in: 1, for: getHash(for: nameForSearch)))

nameForSearch = "Igor"
print(searchInBinaryTree(in: 1, for: getHash(for: nameForSearch)))
