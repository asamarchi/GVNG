//  Copyright © 2016 Compass. All rights reserved.

import Foundation
import Dispatch

public class Replay<T>: Observable<T> {
    private let threshold: Int
    private var events: [Event<E>] = []

    public init(_ threshold: Int) {
        self.threshold = threshold
    }

    public override func subscribe(queue: DispatchQueue? = nil, onNext: ((T) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onDone: (() -> Void)? = nil) {
        super.subscribe(queue: queue, onNext: onNext, onError: onError, onDone: onDone)
        replay(queue: queue, handler: createHandler(onNext: onNext, onError: onError, onDone: onDone))

    }

    public override func on(_ event: Event<E>) {
        switch event {
        case .next:
            events.append(event)
            events = Array(events.suffix(threshold))
        default: break
        }
        super.on(event)
    }

    private func replay(queue: DispatchQueue?, handler: @escaping (Event<E>) -> Void) {
        events.forEach { event in notify(subscriber: Subscriber(queue: queue, handler: handler), event: event) }
    }
}
