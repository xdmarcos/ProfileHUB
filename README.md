# ProfileHUB

Simple App to show GitHub user's profile and repositories.

It shows on screen:

- Main user information (image, name, login, email, followers, following).

- 3 first of pinned repositories.

- 10 first of top and starred repositories.

The project uses:

- The GitHub GraphQL API [Docs](https://docs.github.com/en/graphql).

- Apollo GraphQL iOS framework [Docs](https://www.apollographql.com/docs/ios/).

## Author

Marcos A. González Piñeiro

- [LinkedIn](https://www.linkedin.com/in/marcosagonzalezpinheiro/)

- [Github](https://github.com/xdmarcos/)

- [Email](mailto:xdmgzdev@gmail.com)

- [Assignment repository](https://github.com/xdmarcos/ProfileHUB)

## Description

The assigment implementation is divided in two folders:

- ****Github-Profile:**** Contains the iOS Application related files.

- ****Packages:**** Contains the the self develop Swift Packages with code uses in the main iOS Application.

- ProfileHUB, has 2 schemes (PROD and STAGE) this was meant just to demonstrate a possible project configuration with 2 environments.

- For the purpose of the assessment ****PROD**** should be used since it uses my GitHub username to fetch the information.

- Stage scheme will fetch a user's desired profile after entering it in the promt on startup.

## Usage

Open ProfileHUB.workspace select `ProfileHUB` scheme which will run on PROS configuration, and simple build and run on the simulator/device. (for device new signing certificate and provisioning profile are required)

The peroject is configured to run in iOS 13.6 or later.

## Features

👨‍💻 Fetch user profile from different GitHub users, the PROD (my personal user profile `xdmarcos`) and STAGE (open to the App's user to enter a desires user profile)

👨‍💻Display content from GitHub GraphQL API in a UICollectionView with Diffable datasources and compositional layout.

👨‍💻 All the UI is written programmatically using UIKit and Autolayout.

👨‍💻 Creation of modules containing the reusable components using SPM.

👨‍💻 Accessibility support for Dynamic Font Sizing.

👨‍💻 Beautiful UI in both Light and Dark mode.

👨‍💻 Localized into three languages: English(default), Spanish, Dutch.

👨‍💻 1 day in disk cache.

👨‍💻 Pull to refresh.

## Roadmap

📍 Get familiar with GitHub GraphQL API project to understand it and test it.

📍 Add project setup with 2 schemes and 4 configurations.

📍 Add view hierarchy and initial datasource.

📍 Add MVP components and logic.

📍 Add Apollo and its configuration.

📍 Add GitHub GraphQL schema and user profile repositories queries.

📍 Add GraphQLProvider (client+interceptors).

📍 Add Repository pattern implementation.

📍 Add packages to provide support to Image download and cahce, UI and common components.

📍 Add support for diffable datasources.

📍 Add flow coordinators.

📍 Add support for dark mode and dynamic sizes.

📍 Add locasitions for different languages.

📍 Add unit test target and tests

## Assumptions

During the initial analysis of the assigment I started thinking of what actually could bring value to it and if I decided to build my own components such as ImageCache or CommonUI.

Make use of good software development principles as SOLID, Dependency injection and Dependency inversion and design patterns as MVP, Repository and Coordinator.

Once I started thinking about this, my attention went to two main features:

- Modularizate the project using local swift packages.

- Enforce reusability and testability.

## Personal Goals

I took this opportunity to experiment with new tools and frameworks (This is my first time working activly with GraphQL and Apollo) and pay attention to good practises.

🧩 Use MVP linked via protocols.

👀 Try diffable datasources.

📐Try compositional layouts.

🎛 Project configuration and schemes.

⚓️ Make use of SPM for local dependencies.

🚦 Colors catalogue for Light and Dark Mode.

📥 Apply dependency injection and dependency inversion through protocol.

## Project Architecture

This project follows the [MVP](https://en.wikipedia.org/wiki/Model–view–presenter) design pattern. It also makes use of the [Repository](https://cubettech.com/resources/blog/introduction-to-repository-design-pattern) and [Coordinator](https://khanlou.com/2015/01/the-coordinator/) patterns.

The reason for it (besides it was also mentioned in the assigment as the architecture to apply) was that for the size of this project, ********MVP********   maintains the project structure simple enough and wihtout much boilerplate while still providing all the benefits of any other clean architecture. The main focus is reusability and testability.

## Dependencies

The application has an external dependency on Apollo iOS framework [Docs](https://www.apollographql.com/docs/ios/).

The app also needs a Personal Access Token ([PTA](https://docs.github.com/en/graphql/guides/forming-calls-with-graphql#authenticating-with-graphql)) to be able to access the GitHub API.

### Localization

This project uses `Localizable.strings` and `InfoPlist.strings` to localize the app. This files can be found at `Github-Profile/App/Supporting Files` folder.

## Project Structure

- ********Packages********: Contains the local SPM packages. Common, CommonUI and ImageCache.

- ********Github-Profile:******** Contains all the files related to the iOS Application.

- ********App:******** Contains the AppDelegate and the Configuration files and SupportingFiles. In case this project needed to support multiple scenes. The SceneDelegate would also fall under this folder.

- ********Model:******** Contains the files related to the model objects.

- ********Presenter:******** Contains the files part of the Presenter component, where the main bussiness logis is implemented.

- ********Repository:******** Contains the files to provide the user profile and repositories list to the presenter.

- ********Services:******** Contains the GitHub service implementation together with an GpraphQL client to provide the user profile/repositories from the  GraphQL server.

## Navigation

For the current project, and with the intention of keeping things simple enough, the repositories from the provided QraphQL API will be shown in a UICollectionView.

When a cell is selected by the user, the app will open a empty detail screen just for the show how purpose.

## Unit Tests

The project at its current state contains a set of tests for the main components of the app, such as Presenter or ViewControlller, the purpose of them is just to show an approach on ow unit test will be.

The tests follow the Given/When/Then format.

Ex. `testLoadData_whenItsAbleToLoadTheContent_updatesDataSource`

For the generation of some mocks I used [Sourcery](https://github.com/krzysztofzablocki/Sourcery), but not as a project dependency. but installed locally using [Hombrew](https://brew.sh)
