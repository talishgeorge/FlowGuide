# FlowGuide

FlowGuide is a sample project to demonstrate the features of MVVM design patterns. The app is using the realtime free news API and uses the latest Swfit 5.1 coding style

https://newsapi.org/docs/endpoints/top-headlines

## Installation

The project has developed using XCode 11.3+ and uses the deployment target as iOS 13.2

Open the project using workspace file

## Features
1. OnBoarding screen
2. Login and Signup using Firebase SDK
3. News listing and Details screen
4. Settings screen
5. Split IO integration for enable and disable the features 
   remotely
6. Reusable Network Lib on top Alamofire
 
## Known Issues

If there is any build error, due to  Alamofire swift package manager. Please do a manual update for the first time open the project. 

Normal workflow of Swift package manager:

Xcode project update all packages when it's open. If we stop the indexing/fetching, Xcode will not automatically update the package manager at the build/Run time(This may shows an Error). We have to manually update it from:
Files > Swift Packages > Update to latest package versions

## License
[MIT]
