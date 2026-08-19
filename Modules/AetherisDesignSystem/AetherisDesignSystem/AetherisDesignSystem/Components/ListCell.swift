import SwiftUI

public struct ListCell: View {
    public struct Model {
        public let title: String
        public let subtitle: String
        public let value: String
        public let icon: String

        public init(
            title: String = "Swarovski",
            subtitle: String = "Payment",
            value: String = "-46.99",
            icon: String = "bag"
        ) {
            self.title = title
            self.subtitle = subtitle
            self.value = value
            self.icon = icon
        }
    }

    private let model: Model

    public init(model: Model = .init()) {
        self.model = model
    }
    
    public var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.small, style: .continuous)
                    .fill(Color.brandPrimaryColor.opacity(0.12))
                    .frame(width: AppComponentMetrics.listCellAvatarSize, height: AppComponentMetrics.listCellAvatarSize)
                
                Image(systemName: model.icon)
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: AppComponentMetrics.listCellIconSize.width, height: AppComponentMetrics.listCellIconSize.height)
                    
            }
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .foregroundStyle(Color.textPrimary)
                
                Text(model.subtitle)
                    .font(AppTypography.caption)
                    .foregroundStyle(Color.textSecondaryColor)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            
            Spacer()
            
            Text(model.value)
                .foregroundStyle(Color.textSecondaryColor)
                .padding(AppSpacing.medium)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            ListCellSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        ListCell(
            model: .init(
                title: "Swarovski",
                subtitle: "Payment",
                value: "-$46.99",
                icon: "bag"
            )
        )

        ListCell(
            model: .init(
                title: "Salary",
                subtitle: "Income",
                value: "+$2,800.00",
                icon: "arrow.down"
            )
        )
    }
    .padding(.vertical)
    .appScreenBackground()
}
