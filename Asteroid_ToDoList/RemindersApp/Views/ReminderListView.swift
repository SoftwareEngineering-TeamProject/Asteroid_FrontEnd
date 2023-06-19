//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/9/23.
//

import SwiftUI
import CoreData

struct ReminderListView: View {
    
    let myList: MyList
    let listId : Int
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false

    
    @State var delayCall: DispatchWorkItem?
    @State private var status = "To Do"
    @FetchRequest
    private var reminders: FetchedResults<Reminder>
    
    let userDataManager = UserDataManager()
    let userId = UserDefaults.standard.object(forKey: "userId") as? Int ?? 0
    
    init(myList: MyList, listId : Int) {
        
        self.myList = myList
        self.listId = listId
        _reminders = FetchRequest(fetchRequest: myList.remindersByMyListRequest)
        userDataManager.getTasks(userId: userId , listId: listId)
    }
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    private func delayCall(delay: Double, completion: @escaping () -> ()) {
        
        // cancel any existing call
        delayCall?.cancel()
        
        delayCall = DispatchWorkItem {
            completion()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: delayCall!)
        
    }
    
    private func reminderCheckedChanged(reminder: Reminder) {
        
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        
        
        do {
            try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {}
        
    }
    
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                userDataManager.deleteTask(userId: userId, listId: index)
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error)
            }
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    var body: some View {
        VStack {
            List {
                
                ForEach(reminders) { reminder in
                    if (status == "To Do" && !reminder.isCompleted) || (status == "Completed" && reminder.isCompleted){
                        ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                            switch event {
                            case .showDetail(let reminder):
                                selectedReminder = reminder
                            case .checkedChanged(let reminder):
                                reminderCheckedChanged(reminder: reminder)
                            case .select:
                                showReminderDetail = true
                            }
                        }
                    }
                }.onDelete(perform: deleteReminder)
                
            }
            .toolbar {

                ToolbarItem(placement: .confirmationAction) {
                    Picker("",selection: $status) {
                                    Text("To Do").tag("To Do")
                                    Text("Completed").tag("Completed")
                                }
                }
                
                
            }

            Spacer()
            
            HStack {
                Image(systemName: "plus.circle.fill")
                
                Button("New Reminder") {
                    openAddReminder = true
                }
                Spacer()
                Button("날짜 및 시간 순 정렬") {
                    myList.sortRemindersByDateAndTime()
                    
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        
        .sheet(isPresented: $showReminderDetail, content: {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        })
        
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    selectedReminder = nil
                }.opacity(selectedReminder != nil ? 1.0: 0.0)
            }
        })
        .alert("New Reminder", isPresented: $openAddReminder, actions: {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) { }
            Button("Done") {
                if isFormValid {
                    print(userId, listId, title)
                    userDataManager.postTasks(userId: userId, listId: listId, content: title, completed: false)
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                            
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        })
        
        .navigationTitle(myList.name)
        .navigationBarTitleDisplayMode(.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}




