import UIKit

open class GenericTableView<T: UITableViewCell>: UITableView {
    
    private let cellIdentifier = "cell"
    private let loadCellIdentifier = "load"
    private let cellType: T.Type
    
    public init(cellType: T.Type,
                style: UITableView.Style,
                rowHeight: CGFloat,
                estimatedRowHeight: CGFloat) {
        self.cellType = cellType
        
        super.init(frame: .zero, style: style)
        
        register(cellType, forCellReuseIdentifier: cellIdentifier)
        register(LoadCell.self, forCellReuseIdentifier: loadCellIdentifier)
        
        self.rowHeight = rowHeight
        self.estimatedRowHeight = estimatedRowHeight
        
        // Always set a estimated row height.
        assert(estimatedRowHeight != UITableView.automaticDimension)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    #if DEBUG
    open override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        super.register(cellClass, forCellReuseIdentifier: identifier)
        // https://stackoverflow.com/a/50798789/7715250
        guard let registeredCellClasses = value(forKey: "_cellClassDict") as? [String: Any] else {
            return
        }
        let uniqueClassNames = Set(registeredCellClasses.map { String(describing: $0.value) })
        assert(uniqueClassNames.count == registeredCellClasses.count)
        
        let uniqueIdentifiers = Set(registeredCellClasses.map { String(describing: $0.key) })
        assert(uniqueIdentifiers.count == registeredCellClasses.count)
    }
    #endif
    
    /// Make sure that if this tableView is loadable, you don't try to access
    /// the last cell for the indexpath while it is loading, since than you get a
    /// cast exception.
    public func getCell(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! T
    }
    
    /// This has to be called when the load cell will become visible.
    public func configureLoadCell(indexPath: IndexPath) -> LoadCell {
        let cell = dequeueReusableCell(withIdentifier: loadCellIdentifier, for: indexPath) as! LoadCell
        
        cell.indicator.startAnimating()
        
        return cell
    }
}
