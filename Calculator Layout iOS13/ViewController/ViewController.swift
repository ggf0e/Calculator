import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets:
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    private let calculator = CalculateManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureButtonRadius()
    }
    
    private func configureButtonRadius() {
        for button in buttons {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    
    // MARK: - Actions:
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            calculator.inputNumber(number)
            mainLabel.text = calculator.currentNumber
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard let symbol = sender.titleLabel?.text else { return }
        switch symbol {
            case "+": calculator.setOperation(.plus)
            case "-": calculator.setOperation(.minus)
            case "×": calculator.setOperation(.multiple)
            case "÷": calculator.setOperation(.division)
            case "%": calculator.setOperation(.percent)
            default: break
        }
        secondaryLabel.text = String(format: "\(calculator.secondaryNumber) \(calculator.displayOperation)")
        mainLabel.text = calculator.currentNumber
    }
    
    @IBAction func resultPressed(_ sender: UIButton) {
        calculator.calculateResult()
        mainLabel.text = calculator.currentNumber
        secondaryLabel.text = calculator.secondaryNumber
    }
    
    @IBAction func docimalPressed(_ sender: UIButton) {
        calculator.inputDecimal()
        mainLabel.text = calculator.currentNumber
    }
    
    @IBAction func togglePressed(_ sender: UIButton) {
        calculator.toggleSign()
        mainLabel.text = calculator.currentNumber
    }
    
    @IBAction func clearLabelPressed(_ sender: UIButton) {
        calculator.reset()
        mainLabel.text = calculator.currentNumber
        secondaryLabel.text = ""
    }
}



