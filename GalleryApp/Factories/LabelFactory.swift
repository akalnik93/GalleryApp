import UIKit

class LabelFactory: UILabel {
    
    open class var standart: UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = .black
        return label
    }
    
    open class var standartRight: UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = .black
        return label
    }

}
