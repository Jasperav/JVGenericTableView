import UIKit

open class GenericLoadableTableView<T: UITableViewCell>: GenericTableView<T> {
    
    private let loadCellIdentifier = "load"
    
    public override init(cellType: T.Type,
                style: UITableView.Style,
                rowHeight: CGFloat,
                estimatedRowHeight: CGFloat) {

        super.init(cellType: cellType, style: style, rowHeight: rowHeight, estimatedRowHeight: estimatedRowHeight)
        
        register(LoadCell.self, forCellReuseIdentifier: loadCellIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// This has to be called when the load cell will become visible.
    public func configureLoadCell(indexPath: IndexPath) -> LoadCell {
        let cell = dequeueReusableCell(withIdentifier: loadCellIdentifier, for: indexPath) as! LoadCell
        
        cell.indicator.startAnimating()
        
        return cell
    }
}
