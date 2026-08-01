import Foundation
import SwiftData

@Model
public final class ProfileRecord {
    @Attribute(.unique) public var key: String
    public var isSeeded: Bool
    public var name: String
    public var email: String
    public var phone: String

    public init(
        key: String = "profile",
        isSeeded: Bool = false,
        name: String = "",
        email: String = "",
        phone: String = ""
    ) {
        self.key = key
        self.isSeeded = isSeeded
        self.name = name
        self.email = email
        self.phone = phone
    }
}

@Model
public final class RecentRecipientRecord {
    @Attribute(.unique) public var pixKey: String
    public var id: String
    public var name: String
    public var image: String
    public var hasDivider: Bool
    public var lastUsedAt: Date

    public init(
        pixKey: String,
        id: String,
        name: String,
        image: String,
        hasDivider: Bool,
        lastUsedAt: Date = .now
    ) {
        self.pixKey = pixKey
        self.id = id
        self.name = name
        self.image = image
        self.hasDivider = hasDivider
        self.lastUsedAt = lastUsedAt
    }
}

@MainActor
public final class AppPersistenceController {
    public static let shared = AppPersistenceController()

    public let container: ModelContainer

    public var context: ModelContext {
        container.mainContext
    }

    private init() {
        let schema = Schema([
            ProfileRecord.self,
            RecentRecipientRecord.self
        ])

        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        container = try! ModelContainer(for: schema, configurations: [configuration])
    }

    public func profileRecord() -> ProfileRecord {
        let descriptor = FetchDescriptor<ProfileRecord>(
            predicate: #Predicate { $0.key == "profile" }
        )

        if let existing = try? context.fetch(descriptor).first {
            return existing
        }

        let record = ProfileRecord()
        context.insert(record)
        saveContext()
        return record
    }

    public func recentRecipientRecords(limit: Int = 4) -> [RecentRecipientRecord] {
        let descriptor = FetchDescriptor<RecentRecipientRecord>(
            sortBy: [SortDescriptor(\.lastUsedAt, order: .reverse)]
        )

        let records = (try? context.fetch(descriptor)) ?? []
        return Array(records.prefix(limit))
    }

    public func upsertRecentRecipient(
        id: String,
        name: String,
        pixKey: String,
        image: String,
        hasDivider: Bool
    ) {
        let descriptor = FetchDescriptor<RecentRecipientRecord>(
            predicate: #Predicate { $0.pixKey == pixKey }
        )

        let record = (try? context.fetch(descriptor).first) ?? {
            let record = RecentRecipientRecord(
                pixKey: pixKey,
                id: id,
                name: name,
                image: image,
                hasDivider: hasDivider
            )
            context.insert(record)
            return record
        }()

        record.id = id
        record.name = name
        record.image = image
        record.hasDivider = hasDivider
        record.lastUsedAt = .now
        saveContext()
    }

    public func saveChanges() {
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            assertionFailure("Failed to save SwiftData context: \(error)")
        }
    }
}
