//
//  Quickly
//

#if os(iOS)

    import UIKit

    open class QTableViewController : UIViewController, IQContentViewController {

        open var tableView: UITableView!
        open var tableTopConstraint: NSLayoutConstraint!

        public var tableController: IQTableController? {
            set(value) {
                self.proxy.tableController = value
                if let tableController: IQTableController = value {
                    tableController.reload()
                }
            }
            get {
                return self.proxy.tableController
            }
        }
        private lazy var proxy: Proxy = Proxy(viewController: self)

        open var statusBarHidden: Bool = false {
            didSet { self.setNeedsStatusBarAppearanceUpdate() }
        }
        open var statusBarStyle: UIStatusBarStyle = .default {
            didSet { self.setNeedsStatusBarAppearanceUpdate() }
        }
        open var statusBarAnimation: UIStatusBarAnimation = .fade {
            didSet { self.setNeedsStatusBarAppearanceUpdate() }
        }
        open var supportedOrientationMask: UIInterfaceOrientationMask = .portrait
        open var navigationBarHidden: Bool = false
        open var toolbarHidden: Bool = true
        open var isAppeared: Bool = false

        open override var prefersStatusBarHidden: Bool {
            get { return self.statusBarHidden }
        }
        open override var preferredStatusBarStyle: UIStatusBarStyle {
            get { return self.statusBarStyle }
        }
        open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
            get { return self.statusBarAnimation }
        }
        open override var shouldAutorotate: Bool {
            get { return true }
        }
        open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            get { return self.supportedOrientationMask }
        }

        public init() {
            super.init(nibName: nil, bundle: nil)
            self.setup()
        }

        public override init(nibName: String?, bundle: Bundle?) {
            super.init(nibName: nibName, bundle: bundle)
            self.setup()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.setup()
        }

        open override func viewDidLoad() {
            super.viewDidLoad()
            self.view.addSubview(self.tableView)
            if #available(iOS 9.0, *) {
                self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

                self.tableTopConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
                self.tableTopConstraint.isActive = true
                self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            }
        }

        open func setup() {
            self.edgesForExtendedLayout = []
            self.automaticallyAdjustsScrollViewInsets = false

            self.tableView = UITableView()
            tableView.backgroundColor = .white
            tableView.translatesAutoresizingMaskIntoConstraints = false
        }

        open func triggeredRefreshControl() {
        }

        open func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
            if let navigationController: UINavigationController = self.navigationController {
                navigationController.setNavigationBarHidden(hidden, animated: animated)
            }
            self.navigationBarHidden = hidden
        }

        open func setToolbarHidden(_ hidden: Bool, animated: Bool) {
            if let navigationController: UINavigationController = self.navigationController {
                navigationController.setToolbarHidden(hidden, animated: animated)
            }
            self.toolbarHidden = hidden
        }

        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.isAppeared = true
            if let navigationController: UINavigationController = self.navigationController {
                navigationController.isNavigationBarHidden = self.navigationBarHidden
                navigationController.isToolbarHidden = self.toolbarHidden
            }
        }

        open override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            self.isAppeared = false
        }

        open func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // implemnt me if needed
        }

        private class Proxy: NSObject, UITableViewDataSource, UITableViewDelegate {

            public weak var viewController: QTableViewController?
            public var tableController: IQTableController? = nil {
                willSet { self.cleanupTableController() }
                didSet { self.prepareTableController() }
            }

            public init(viewController: QTableViewController?) {
                self.viewController = viewController
                super.init()
            }

            deinit {
                if let tableController: IQTableController = self.tableController {
                    tableController.tableView = nil
                }
            }

            public func configure() {
                self.cleanupTableController()
                self.prepareTableController()
            }

            private func prepareTableController() {
                if let viewController = self.viewController {
                    viewController.tableView.delegate = self
                    viewController.tableView.dataSource = self
                    if let tableController: IQTableController = self.tableController {
                        tableController.tableView = viewController.tableView
                    }
                }
            }

            private func cleanupTableController() {
                if let viewController = self.viewController {
                    viewController.tableView.delegate = nil
                    viewController.tableView.dataSource = nil
                }
                if let tableController: IQTableController = self.tableController {
                    tableController.tableView = nil
                }
            }

            public override func responds(to selector: Selector!) -> Bool {
                if super.responds(to: selector) {
                    return true
                }
                if let tableController: IQTableController = self.tableController {
                    if tableController.responds(to: selector) {
                        return true
                    }
                }
                if let viewController: QTableViewController = self.viewController {
                    if viewController.responds(to: selector) {
                        return true
                    }
                }
                return false
            }

            public override func forwardingTarget(for selector: Selector!) -> Any? {
                if super.responds(to: selector) {
                    return self
                }
                if let tableController: IQTableController = self.tableController {
                    if tableController.responds(to: selector) {
                        return tableController
                    }
                }
                if let viewController: QTableViewController = self.viewController {
                    if viewController.responds(to: selector) {
                        return viewController
                    }
                }
                return nil
            }

            // почему-то этот метод (а видимо и все сейчаство UIScrollViewDelegate) не пролетает через forwardingTarget
            // поэтому приходится это делать вручную *facepalm* предположения?!
            func scrollViewDidScroll(_ scrollView: UIScrollView) {
                viewController?.scrollViewDidScroll(scrollView)
            }

            public func tableView(
                _ tableView: UITableView,
                numberOfRowsInSection index: Int
                ) -> Int {
                if let tableController: IQTableController = self.tableController {
                    return tableController.tableView(tableView, numberOfRowsInSection: index)
                }
                return 0
            }

            public func tableView(
                _ tableView: UITableView,
                cellForRowAt indexPath: IndexPath
                ) -> UITableViewCell {
                if let tableController: IQTableController = self.tableController {
                    return tableController.tableView(tableView, cellForRowAt: indexPath)
                }
                return UITableViewCell(style: .default, reuseIdentifier: "Unknown")
            }

        }

    }

#endif

