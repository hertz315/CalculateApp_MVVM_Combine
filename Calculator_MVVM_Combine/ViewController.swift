//
//  ViewController.swift
//  Calculator_MVVM_Combine
//
//  Created by Hertz on 10/29/22.
//

import UIKit
import Combine

// MARK: - 계산타입 정의
enum Calculate {
    case plus
    case minus
    case multiply
    case divide
    case empty
    
    /// 문자열을 enum클래스의 타입으로 바꿔주는 코드
    static func initialize(_ btnTitle : String) -> Self {
        switch btnTitle {
        case "+": return .plus
        case "%": return .divide
        case "X": return .multiply
        case "-": return .minus
        default: return .empty
        }
    }
    
    /// 계산연산자
    var infoString : String {
        switch self {
        case .plus: return "더하기"
        case .minus: return "빼기"
        case .multiply: return "곱하기"
        case .divide: return "나누기"
        case .empty: return "nil"
        }
    }
}


class ViewController: UIViewController {
    
    // MARK: - @IBOulet
    @IBOutlet var firstInputLabel: UILabel!
    @IBOutlet var formulaLabel: UILabel!
    @IBOutlet var secondInputLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var digitsButton: [UIButton]!
    @IBOutlet var formulaButton: [UIButton]!
    
    // MARK: - Vars
    let calculateVM = CalculateVM()
    var subscriptions = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    
    @IBAction func formulaButtonTapped(_ sender: UIButton) {
        let sss = Calculate.initialize(sender.currentTitle ?? "")
        self.calculateVM.formulaButtonTapped(sss)
    }
    
    
    @IBAction func DigitButtonTapped(_ sender: UIButton) {
        let number = sender.currentTitle ?? ""
        self.calculateVM.digitButtonState(number)
        
    }
    
    
    @IBAction func doCalculateButtonTapped(_ sender: UIButton) {
        self.calculateVM.doCalculate()
    }
    
    
    
}

extension ViewController {
    fileprivate func bindUI() {
        calculateVM.$firstInput
            .map{ "\($0)" }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: firstInputLabel)
            .store(in: &subscriptions)
        
        calculateVM.$formulaStatus
            .compactMap{ $0?.infoString ?? "" }
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: formulaLabel)
            .store(in: &subscriptions)
        
        calculateVM.$secondInput
            .map{ " \($0) "}
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: secondInputLabel)
            .store(in: &subscriptions)
        
        calculateVM.$resultValue
            .map{ "\($0)" }
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.resultLabel.text = value
            }
            .store(in: &subscriptions)
        
        
    }
}
