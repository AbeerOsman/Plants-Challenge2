import SwiftUI

struct PlantsView: View {
    @StateObject private var viewModel = PlantsViewModel()
    @Binding var countReminders: Double
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        ZStack {

            
            VStack(alignment: .leading) {
                Text("My Plants 🌱")
                    .font(.system(size: 34))
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.bottom, 5)

                Divider()
                    .frame(height: 2)
                    .background(Color(hex: "39393B").opacity(0.6))

                Spacer()
            }
            .padding()

            VStack(spacing: 37) {
                if !viewModel.hasReminders {
                    emptyState
                } else {
                    TodayReminderView(
                        reminders: $viewModel.reminders,
                        countReminders: $countReminders,
                        showSetReminderSheet: $viewModel.showSetReminderSheet
                    )
                    .padding(.top, 90)
                }

                addButton
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        
    }
    
//Empty View
    private var emptyState: some View {
        VStack (spacing:37){
            Image(.plant)
            Text("Start your plant journey!")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(hex: "#9F9F91"))
                .padding(.bottom, 40)
                .padding(.horizontal, 25)
        }
    }
//Add Button View
    private var addButton: some View {
        Group {
            if !viewModel.hasReminders {
                VStack {
                    Button(action: {
                        viewModel.toggleReminderSheet()
                    }) {
                        Text("Set Plant Reminder")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .medium))
                            .padding()
                            .frame(width: 280, height: 44)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color(hex: "#19B183").opacity(45))
                    .sheet(isPresented: $viewModel.showSetReminderSheet) {
                        NavigationStack {
                            SetReminderView(
                                showSetReminderSheet: $viewModel.showSetReminderSheet,
                                reminders: $viewModel.reminders
                            )
                        }
                    }
                }
            } else {
                VStack(alignment: .trailing) {
                    Button(action: {
                        viewModel.toggleReminderSheet()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .medium))
                            .padding()
                            .frame(width: 48, height: 48)
                            .background(Color(hex: "#19B183").opacity(45))
                            .cornerRadius(60)
                    }
                    .glassEffect()
                    .sheet(isPresented: $viewModel.showSetReminderSheet) {
                        NavigationStack {
                            SetReminderView(
                                showSetReminderSheet: $viewModel.showSetReminderSheet,
                                reminders: $viewModel.reminders
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    PlantsView(countReminders: .constant(0))
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
