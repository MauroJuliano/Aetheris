import Foundation

extension String {
    func chunked(into size: Int) -> [String] {
        guard size > 0 else { return [self] }

        return stride(from: 0, to: count, by: size).map { startOffset in
            let startIndex = index(self.startIndex, offsetBy: startOffset)
            let endOffset = min(startOffset + size, count)
            let endIndex = index(self.startIndex, offsetBy: endOffset)

            return String(self[startIndex..<endIndex])
        }
    }
}
