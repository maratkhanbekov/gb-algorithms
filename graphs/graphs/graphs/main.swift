//
//  main.swift
//  graphs
//
//  Created by Marat Khanbekov on 22.01.2021.
//

import Foundation

//1. Написать функции, которые считывают матрицу смежности из файла и выводят ее на экран.
let graph = [
    [0, 1, 1, 1, 0],
    [1, 0, 1, 0, 0],
    [1, 1, 0, 0, 1],
    [1, 0, 0, 0, 0],
    [0, 0, 1, 0, 0]
]

var visited: [Int] = []
var stack: [Int] = []

//2. Написать рекурсивную функцию обхода графа в глубину.

func dsf(from vertex: Int) {
    
    visited.append(vertex)
    
    var neighbours: [Int] = []
    for i in 0..<graph[vertex].count {
        if graph[vertex][i] == 1 && !visited.contains(i) && !stack.contains(i) {
            neighbours.append(i)
        }
    }
    
    stack.insert(contentsOf: neighbours, at: 0)
    
    print("Посетили:", visited)
    print("Стэк:", stack)
    
    if stack.count > 0 {
        dsf(from: stack.removeFirst())
    }
}

print("===== Обход графа в глубину")
dsf(from: 0)

visited = []
stack = []

//3. Написать функцию обхода графа в ширину.
func bsf(from vertex: Int) {
    visited.append(vertex)
    
    for i in 0..<graph[vertex].count {
        if graph[vertex][i] == 1 && !visited.contains(i) && !stack.contains(i) {
            stack.append(i)
        }
    }
    
    print("Посетили:", visited)
    print("Стэк:", stack)
    
    if stack.count > 0 {
        bsf(from: stack.removeFirst())
    }
    
}
print("===== Обход графа в ширину")
bsf(from: 0)

// 4. Дейкстра
print("===== Алгоритм Дейкстры")
let graphForD = [
    [0,  7,  9,  0,  0, 14],
    [7,  0,  10, 15, 0, 0],
    [9,  10, 0,  11, 0, 2],
    [0,  15, 11, 0,  6, 0],
    [0,  0,  0,  6,  0, 9],
    [14, 0,  2,  0,  9, 0],
]

let startVertex = 0
var distances: [Int] = []
let infinity = 10000

// Заполняем дистации "бесконечным числом"
for i in 0..<graphForD.count {
    distances.append(infinity)
}

// Инициализиуем стартовую вершину
distances[startVertex] = 0

var neigbs: [Int] = []
visited = []

func algoD(for vertex: Int) {
    
    // Если посещали вершину, то выходим из функции
    if visited.contains(vertex) {
        return
    }

    // Находим соседние вершины
    for i in 0..<graphForD[vertex].count {
        
        if graphForD[vertex][i] > 0 {
            
            // Если посещали вершину, то выходим из функции
            if visited.contains(i) {
                continue
            }
            
            neigbs.append(i)
            
            // Если новое расстояние меньше, то заменяем
            let newDistance = distances[vertex] + graphForD[vertex][i]
            
            if  newDistance < distances[i] {
                distances[i] = newDistance
            }
            
        }
    }
    
    // Добавляем в посещенные
    visited.append(vertex)
    
    print("Посетили:", visited)
    print("Расстояния", distances)
    
    if neigbs.count > 0 {
        algoD(for: neigbs.removeFirst())
    }
}

// Просчитываем метки для вершин относительно исходной
algoD(for: startVertex)
var vertexInPath: [Int] = []

func findShortestWay(fromVertex: Int, toVertex: Int) {
    
    // Ищем соседей конечной вершины
    for i in 0..<graphForD[toVertex].count {
        
        if graphForD[toVertex][i] > 0 {
            // Если путь до конечной вершины совпадает с кратчайшем путем до предыдущей и значением ребра
            if distances[toVertex] - graphForD[toVertex][i] == distances[i] {
                // Добавляем вершину в путь
                vertexInPath.insert(i, at: 0)
                print("Вершины на пути", vertexInPath)
                // Ищем путь до этй вершины
                findShortestWay(fromVertex: fromVertex, toVertex: i)
                
                // Если нашли кратчайший путь, то второй аналогичный не ищем
                continue
            }
        }
    }
}

findShortestWay(fromVertex: startVertex, toVertex: 4)
