//  Copyright © 2016 Compass. All rights reserved.

import Foundation
import Dispatch

public class Just<T>: Observable<T> {
    private let value: T

    public init(_ value: T) {
        self.value = value
        super.init()
    }

    public override func subscribe(queue: DispatchQueue? = nil, onNext: ((T) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onDone: (() -> Void)? = nil) {
        let handler = createHandler(onNext: onNext, onError: onError, onDone: onDone)
        notify(subscriber: Subscriber(queue: queue, handler: handler), event: .next(value))
        notify(subscriber: Subscriber(queue: queue, handler: handler), event: .done)
    }
}
