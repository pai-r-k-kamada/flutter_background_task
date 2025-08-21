enum ServiceEvents: Int {
    case Monitor = 0
    case Range = 1
    case Location = 2
    
    func getName() -> String {
        switch self {
        case .Monitor: return "monitor_notifier"
        case .Range:  return "range_notifier"
        case .Location:  return "location_notifier"
        }
    }
}
