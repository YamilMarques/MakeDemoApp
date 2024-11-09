# Make - Android App Example #

This app serves as an example of how to build an Android APK without using Gradle, Ant or any other automated building tool.

I made this app with the goal of putting in practice the under the hood building system that Android uses for its APKs. The goal of this project is just for researching purposes and learning. Building the app without a Automated building tool is a taxing task and will require higher amount of resources for development and mantainance. I strongly won't recomend to use this methodology in productive Apps unless strictly necessary or if its a technical advantage over using an Automated building tool such as Gradle or Ant.

## Building Steps ##

Make sure that you have the Build Tools from the Android SDK as environment variables for an easy use, otherwhise you can always reference them in the script doing the proper modifications.


Clone this project
`git clone https://github.com/YamilMarques/MakeDemoApp.git`  

Change to project directory
`cd MakeDemoApp`  

Build it  
`sh build_new.sh`    

Follow the script instructions. The APK built will be located in `/builds`.

