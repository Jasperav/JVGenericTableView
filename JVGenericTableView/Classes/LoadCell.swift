import UIKit
import JVConstraintEdges
import JVDebugProcessorMacros

open class LoadCell: UITableViewCell {
    
    let indicator = UIActivityIndicatorView(style: .medium)
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupIndicator()
        setupContentView()
        
        isUserInteractionEnabled = false
        backgroundColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension LoadCell: ViewLayout {
    private func setupIndicator() {
        indicator.layoutInMiddle(inView: contentView)
    }
    
    private func setupContentView() {
        contentView.layoutEqualHeight(view: indicator, constant: 10)
    }
}
