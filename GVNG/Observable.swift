//  Copyright © 2016 Compass. All rights reserved.

import Foundation
import Dispatch

public class Observable<T> : ObservableType {
    public typealias E = T
    private var isStopped: Int32 = 0
    private var stoppedEvent: Event<E>?
    var subscribers: [Subscriber<E>] = []

    public init() {}

    func createHandler(onNext: ((T) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onDone: (() -> Void)? = nil) -> (Event<E>) -> Void {
        return { event in
            switch event {
            case .next(let t): onNext?(t)
            case .error(let e): onError?(e)
            case .done: onDone?()
            }
        }
    }

    public func subscribe(queue: DispatchQueue? = nil, onNext: ((T) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onDone: (() -> Void)? = nil) {
        if let event = stoppedEvent {
            notify(subscriber: Subscriber(queue: queue, handler: createHandler(onNext: onNext, onError: onError, onDone: onDone)), event: event)
            return
        }
        subscribers.append(Subscriber(queue: queue, handler: createHandler(onNext: onNext, onError: onError, onDone: onDone)))
    }

    public func on(_ event: Event<E>) {
        switch event {
        case .next:
            guard isStopped == 0 else {
                return
            }
            subscribers.forEach { notify(subscriber: $0, event: event) }
        case .error, .done:
            if OSAtomicCompareAndSwap32Barrier(0, 1, &isStopped) {
                subscribers.forEach { notify(subscriber: $0, event: event) }
                stoppedEvent = event
            }
        }
    }

    public func removeSubscribers() {
        subscribers.removeAll()
    }

    func notify(subscriber: Subscriber<E>, event: Event<E>) {
        guard let queue = subscriber.queue else {
            subscriber.handler(event)
            return
        }

        if queue == DispatchQueue.main && Thread.isMainThread {
            subscriber.handler(event)
        } else {
            queue.async {
                subscriber.handler(event)
            }
        }
    }
}
