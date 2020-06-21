# FlowGuide
        FlowGuide is a sample project to demonstrate the features of MVVM design patterns. 

## Development setup
        The project has developed using XCode 11.3 and uses the deployment target as iOS 13.2

## Release History
    1.0.0
        . OnBoarding screen
        . Login and Signup using Firebase SDK
        . News listing and Details screen
        . Settings screen
        . Split IO integration for enable and disable the features 
           remotely
        . Reusable Network Lib on top of Alamofire

## API
        The app is using the realtime free news API 
        https://newsapi.org/docs/endpoints/top-headlines

## Known Issues
        If there is any build error, due to  Alamofire swift package manager.
        Please do a manual update for the first time open the project. 

        Normal workflow of Swift package manager:
        Xcode project update all packages when it's open. If we stop the indexing/fetching, 
        Xcode will not automatically update the package manager at the build/Runtime
        (This may shows an Error). We have to manually update it from:
        Files > Swift Packages > Update to latest package versions

