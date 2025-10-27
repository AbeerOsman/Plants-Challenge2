# Planto
<img width="150" height="150" alt="image" src="https://github.com/user-attachments/assets/fa20ac28-8346-44fe-94d0-6a5804fafdf8" />

Plant Care reminders 🌿 

Planto is a SwiftUI-based iOS app that helps plant lovers keep their plants healthy and thriving. The app allows users to set, edit, and manage watering reminders for different plants, track their progress, and receive local notifications when it’s time to care for a plant.

------------------------------------------------------------------------------------------------------------------------------------

# UI Preview

<img width="200" height="500" alt="IMG_1190" src="https://github.com/user-attachments/assets/24325069-f778-43e0-92d6-02e742ef3c29" /> <img width="200" height="500" alt="IMG_1191" src="https://github.com/user-attachments/assets/05707ecf-ed8a-4c55-b53d-6581737ce3a2" /> <img width="200" height="500" alt="IMG_1189" src="https://github.com/user-attachments/assets/10cf2743-30d5-4c90-a84d-5f9fcdecda2c" /> <img width="200" height="500" alt="IMG_1193" src="https://github.com/user-attachments/assets/4ccd269b-b064-4962-9295-abdae7ef4997" /> <img width="200" height="500" alt="IMG_1194" src="https://github.com/user-attachments/assets/52e6e8c8-7b6f-4894-bd47-7ebaf899c5f6" /> <img width="200" height="500" alt="IMG_1195" src="https://github.com/user-attachments/assets/5b1ba2b4-1f31-4797-8400-fff351d7cf5b" /> <img width="200" height="500" alt="IMG_1197" src="https://github.com/user-attachments/assets/cf3e7b3c-44e9-4d40-884e-a4e888729c58" /> <img width="200" height="500" alt="IMG_1198" src="https://github.com/user-attachments/assets/3ecae490-e1fa-439e-9a5f-7a6db09739b6" />


------------------------------------------------------------------------------------------------------------------------------------

# Features

* Add and edit plant reminders
Create custom reminders for each plant, including its name, room location, light preference, watering frequency, and water amount.

* Smart scheduling
The app automatically calculates the next due date for watering using the RemindersDateHelper logic.

* Local notifications
Stay on top of your plant care routine with automatic notifications when it’s time to water your plants.

* Clean and minimal SwiftUI design
A user-friendly interface designed for simplicity and clarity.

* Data persistence
Your reminders are stored and updated reliably using SwiftUI’s data bindings and view models.

------------------------------------------------------------------------------------------------------------------------------------

# Architecture

Planto follows the MVVM (Model–View–ViewModel) architecture pattern for clean and maintainable code:
Model:
PlantReminderList – Defines the data structure for plant reminders.

ViewModel:
This part handles logics that we have in the app. 
PlantsViewModel - SetReminderViewModel - EditReminderViewModel – TodayReminderViewModel - NotificationsManager - RemindersDateHelper 

View:
Handle user interaction and display data reactively.
PlantsView - SetReminderView - SetReminderViewForEdit - TodayReminderView 

------------------------------------------------------------------------------------------------------------------------------------

# Technologies Used

* SwiftUI – For the app’s declarative UI
* Combine – For reactive data updates
* UserNotifications Framework – For scheduling and managing local notifications
* MVVM Architecture – For separation of logic and UI
Xcode & Swift 5
* @Environment(\.colorScheme) - For alining with system preference? (Dark & Light Mood)
  
------------------------------------------------------------------------------------------------------------------------------------
# Getting Started

1- Clone the repository:

1- Open in Xcode:
select Clone from remote repo

3- Build & run on an iPhone simulator or device that suport (iOS 26.0).
