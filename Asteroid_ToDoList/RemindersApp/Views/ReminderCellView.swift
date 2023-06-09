//
//  ReminderCellView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/13/23.
//

import SwiftUI
import CoreData


struct ReminderCellView: View {
    
    enum ReminderCellEvents {
        case select
        case checkedChanged(Reminder)
        case showDetail(Reminder)
    }
    
    let reminder: Reminder
    let isSelected: Bool
    let onSelect: (ReminderCellEvents) -> Void
    
    let delay = Delay()
    
    @State private var checked: Bool = false
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    
                    checked.toggle()
                    
                    if checked {
                        delay.performWork {
                            onSelect(.checkedChanged(reminder))
                        }
                    } else {
                        delay.cancel()
                    }
                    
                }.padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
                    
                
            }
            Spacer()
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0: 0.0)
                .onTapGesture {
                    onSelect(.select)
                    //showReminderDetail = true
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            //event = .select(reminder)
            onSelect(.showDetail(reminder))
        }
    }
}

//struct ReminderCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderCellView(reminder: PreviewData.reminder, onReminderSelect: { _ in }, onReminderCheckedChanged: { _ in }, isSelected: true, showReminderDetail: .constant(true))
//    }
//}
