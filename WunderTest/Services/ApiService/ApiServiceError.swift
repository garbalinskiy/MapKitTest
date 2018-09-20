import Foundation

enum ApiServiceError: Error {
    case invalidRequestPath
    case noDataInResponse
}

extension ApiServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidRequestPath:
            return "Final request path is invalid"
        case .noDataInResponse:
            return "Response doesn't have data to decode"
        }
    }
}
