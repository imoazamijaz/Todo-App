Overview
This Todo App is a Flutter-based application designed to help users manage their tasks efficiently. 
It provides a user-friendly interface to view, add, edit, and delete tasks. Users can track tasks in
two categories: Pending and Completed. Tasks can be marked as done, edited, or deleted.

Features
Pending Tasks: View and manage tasks that are yet to be completed.
Completed Tasks: View tasks that have been marked as done.
Edit Tasks: Modify task details including title, description, date, and time.
Delete Tasks: Remove tasks from the list.
Mark as Done: Quickly mark tasks as completed.
Screens
1. Pending Tasks Screen
   Displays a list of tasks that are not yet completed.
   Users can:
   Mark a task as done.
   Click on a task to edit or delete it.
2. Completed Tasks Screen
   Displays a list of tasks that have been marked as completed.
3. Database
   SQLite is used for local database management.
   Supports full CRUD functionality.
   Task details include title, description, time, date, and status.
4. State Management
    GetX is used for state management.
    Handles and displays tasks efficiently.