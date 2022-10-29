//
//  CalculateVM.swift
//  Calculator_MVVM_Combine
//
//  Created by Hertz on 10/29/22.
//

import UIKit
import Combine

final class CalculateVM {
    
    // MARK: - 상태변수
    @Published var firstInput = ""
    @Published var secondInput = ""
    @Published var formulaStatus: Calculate? = nil
    @Published var resultValue = 0
    @Published var resultBox = 0

    var box = 0
    
    // MARK: - 비즈니스 로직
    /// 숫자버튼을 탭할수 호출할 비즈니스 로직
    func digitButtonState(_ number: String) {
        /// 계산식에 값이 들어있지 않다면 첫번째 인풋값에 숫자 추가
        if formulaStatus == nil {
            self.firstInput += number
        } else {
            self.secondInput += number
        }
        
    }

    /// 포뮬러 버튼을 탭할시 호출할 비즈니스 로직
    func formulaButtonTapped(_ formula: Calculate) {
        self.formulaStatus = formula
        
        
    }
    /// 계산하기 버튼을 탭할시 계산하는 비즈니스 로직
    func doCalculate() {
        
        let first = Int(self.firstInput)
        let second = Int(self.secondInput)
       
        
        var resultValue = 0
        self.box += resultValue
        
        if let formula = self.formulaStatus {
            switch formula {
            case .plus:
                self.box = (first ?? 0) + (second ?? 0)
            case .minus:
                self.box = (first ?? 0) - (second ?? 0)
            case .multiply:
                self.box = (first ?? 0) * (second ?? 0)
            case .divide:
                self.box = (first ?? 0) / (second ?? 0)
            case .empty:
                return resultValue = 0
            }
        }
                    
       
        self.resultValue += self.box
        self.firstInput = String("")
        self.secondInput = String("")
        self.formulaStatus = nil
    }
}


