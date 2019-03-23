import UIKit
import JVConstraintEdges

open class LoadCell: UITableViewCell {
    
    let indicator = UIActivityIndicatorView(style: .gray)
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        indicator.fillToMiddle(toSuperview: contentView)
        
        contentView.heightAnchor.constraint(equalTo: indicator.heightAnchor).isActive = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
