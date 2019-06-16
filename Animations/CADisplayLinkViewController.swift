import UIKit

class CADisplayLinkViewController: UIViewController {
    
    @IBOutlet var stocksNumberLabel: UILabel!
    @IBOutlet var bondsNumberLabel: UILabel!
    @IBOutlet var realEstateNumberLabel: UILabel!
    @IBOutlet var totalNumberLabel: UILabel!
    
    var displayLink: CADisplayLink?
    var startValue: Double = 0
    
    let stockEndValue: Double = 543000
    let bondEndValue: Double = 184000
    let realEstateEndValue: Double = 319000
    
    let animationDuration: Double = 1.5
    let animationStartDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.displayLink = CADisplayLink(target: self, selector: #selector(self.handleUpdate))
            self.displayLink?.add(to: .main, forMode: .default)
        }
    }
    
    @objc func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        let totalEndValue = stockEndValue + bondEndValue + realEstateEndValue
                
        if elapsedTime > animationDuration {
            stopDisplayLink()
            self.stocksNumberLabel.text = formatNumber(number: stockEndValue)
            self.bondsNumberLabel.text = formatNumber(number: bondEndValue)
            self.realEstateNumberLabel.text = formatNumber(number: realEstateEndValue)
            self.totalNumberLabel.text = formatNumber(number: totalEndValue)
        } else {
            let percentage = elapsedTime / animationDuration
            let stocksValue = percentage * (stockEndValue - startValue)
            self.stocksNumberLabel.text = formatNumber(number: stocksValue)
            let bondsValue = percentage * (bondEndValue - startValue)
            self.bondsNumberLabel.text = formatNumber(number: bondsValue)
            let realEstateValue = percentage * (realEstateEndValue - startValue)
            self.realEstateNumberLabel.text = formatNumber(number: realEstateValue)
            let totalValue = percentage * (totalEndValue - startValue)
            self.totalNumberLabel.text = formatNumber(number: totalValue)
        }
    }
    
    func formatNumber(number: Double) -> String {
        let wholeNumberValue = Int(number)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: wholeNumberValue)) ?? ""
        let numberWithCurrency = "$\(formattedNumber)"
        return numberWithCurrency
    }
    
    /// Explain this!!!
    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
}
