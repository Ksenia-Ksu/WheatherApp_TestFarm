//
//  Test2.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

func changeMatrix(matrix: inout [[Int]]) {
    for i in 0..<matrix.count {
        for j in (i + 1)..<matrix.count {
            let prev = matrix[i][j]
            matrix[i][j] = matrix[j][i]
            matrix[j][i] = prev
        }
    }
}
