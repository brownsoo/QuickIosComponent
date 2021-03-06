//
//  MvsViewController.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 10. 18..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwift
import ReSwiftConsumer
import RxSwift

open class MvsViewController<S: StateType & Equatable, I: RePageInteractor<S>>
    : StateViewController<S>, LoadingVisible, IntentContainer {

    private(set) var isFirstLayout = true

    public lazy var loadingView = LoadingView()

    public private(set) var intent: NSMutableDictionary = NSMutableDictionary()

    open func createInteractor() -> I? { return nil }

    convenience required public init() {
        self.init(nibName: nil, bundle: nil)
    }

    override open func viewDidLoad() {
        // Before subscription, makes instance of RePageInteractor
        pageInteractor = createInteractor()
        // At this time, it makes subscription with initial state and middle wares
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindUIEvents()
        bindConsumers()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (pageInteractor as? ViewAttach)?.detachView()
        unbindUIEvents()
        unbindConsumers()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLayout {
            isFirstLayout = false
            firstDidLayout()
        }
    }
    /// once called at first layout time
    open func firstDidLayout() {
    }
    /// bind UI events
    /// called in viewWillAppear
    open func bindUIEvents() {}
    /// unbind UI events
    /// called in viewWillDisappear
    open func unbindUIEvents() {
    }
    /// bind Consumers
    /// called in viewWillAppear
    open func bindConsumers() {}
    
    /// bind Consumers
    /// called in viewWillDisappear
    open func unbindConsumers() {
        pageConsumer?.removeAll()
    }
}

extension MvsViewController: AlertPop {
    public func alertPop(_ title: String?,
                         message: String,
                         positive: String? = nil,
                         positiveCallback: ((_ action: UIAlertAction)->Void)? = nil,
                         alt: String? = nil,
                         altCallback: ((_ action: UIAlertAction) -> Void)? = nil) {
        
        alertPop(self,
                 title: title,
                 message: message,
                 positive: positive,
                 positiveCallback: positiveCallback,
                 alt: alt,
                 altCallback: altCallback)
    }
}

