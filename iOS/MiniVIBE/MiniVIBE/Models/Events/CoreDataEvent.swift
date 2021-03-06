//
//  MoveEvent.swift
//  MiniVIBE
//
//  Created by 최동규 on 2020/12/15.
//

import BCEventEmitter

class CoreDataEvent: Event {
    init(cdEvent: CDEvent) {
        let cdParameter = cdEvent.parameter ?? NSSet()
        let parameters = cdParameter.compactMap { setItem -> CDParameter? in
            guard let item = setItem as? CDParameter else { return nil }
            return item
        }.reduce([:], { (dict, pair) -> [String: String]? in
            guard let key = pair.key, let value = pair.value else { return nil }
            guard var parameter = dict else { return nil }
            parameter[key] = value
            return parameter
        })
        super.init(name: cdEvent.name ?? "", parameters: parameters ?? [:], date: cdEvent.dateString ?? "")
    }
    
    init(name: String, parameter: [String: String], date: String = Date().customDateFormat()) {
        super.init(name: name, parameters: parameter, date: date)
    }
}
