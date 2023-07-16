# notes_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

using hive help me to store local database like  key and value like firebase
and the data store in box like collection in firebase 
note : it store only data primitive like int,string .... .
cant store object but there is a way 


## steps  
1. [x] 1- init hive.flutter

2. [x] 2- open box that will store data:
   await Hive.initFlutter();
   Hive.registerAdapter(NoteModelAdapter());
   await Hive.openBox<NoteModel>(myBox);
3. [x] 3-add note to database:
      1- take input from user to store it in database:
           make variable take data from user so i make controller for these field 
      2-create cubit and create method to add data 
          so i make add note and this add note will take for sure note model
4. [x] 4-create method for add notes
            1- fire we get my box
               var notesBox=Hive.box<NoteModel>(myBox);
           2- using notesbox to add data
               notesBox.add(note);
5. [x] 5-Display method for notes
            1- var notesBox = Hive.box<NoteModel>(myBox);
               notesBox.values.toList();and i make to list cuz its its Iterable<NoteModel>
            2- i didnt make any emit loading or error cuz that is not future so that data will come direct

