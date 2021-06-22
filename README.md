# RunnerTracker Application

Flutter application to work on Anroid and IOS devices

## Test Area

Android Emulator and Pyhsical IOS 14.6 device will be used to test the project.

## Important Notes Before Starting Application

-> Sqlite, firebase will be used to store the data. ( Except Login data, which only will be stored in sqlite)
-> Firebase connection only works for IOS ( for now in future will be updated.)


### Login Page Desing 

There are login options; Login via Gmail, login via existed account in the app database.

- [ ]
- [x]

Login via Gmail:
	&#x2611; User click the button and directed to Gmail account page ( LoginState ) 
	- User select an existed account or login their gmail account 
		->  Unsuccessful operation back to the homepage ( HomePageState )
		->  Successful operation user directed to dashboardpage of application ( LoggedInState)  
