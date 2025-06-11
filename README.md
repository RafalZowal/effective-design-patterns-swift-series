[![License: CC BY-NC 4.0](https://licensebuttons.net/l/by-nc/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc/4.0/)

# Your Design-Pattern Roadmap 🚀

Welcome to **Your Design-Pattern Roadmap** — a playful, hands-on project born from a fun and educational 8-part article series where we dive deep into classic design patterns with a twist of humor and practical flair.

---

## What Is This Repo About?

This project is my playground for experimenting with design patterns — inspired by the articles I wrote to demystify and make design patterns approachable and memorable.
The goal? To create code examples and a small network library that apply these patterns, helping anyone curious about design patterns see how they work in a real-ish project.

**Spoiler:** There are already plenty of network libraries out there. This one isn’t trying to replace them — it’s here to be a learning companion and a proof of concept wrapped in a fun package.

---

## Why This Project?

* **Educational** — To make design patterns less scary and more fun.
* **Practical** — To show how patterns like Visitor, Observer, Command, Factory, Builder, Interceptor, Singleton, Facade, Prototype, and Dependency Injection can be applied.
* **Humorous** — Because learning should make you smile.

---

## Read the Articles!

This repo is the companion to a series of articles that break down design patterns in a lighthearted way. Each article focuses on one or two patterns, explaining their purpose and usage through jokes, metaphors, and real code.

Here’s the full roadmap:

| Part | Title & Description                                                                          | Link                                                                                                                                                             |
| ---- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1    | **Introduction and UML Overview**<br>Setting the stage for your pattern journey.             | 👉 [Read Part 1](https://medium.com/@rafal.zowal1985/effective-use-of-design-patterns-in-software-development-best-practices-part-1-8759c67af217)                |
| 2    | **Exploring the Visitor Pattern**<br>A pattern that walks your object structure for you.     | 👉 [Read Part 2](https://medium.com/@rafal.zowal1985/effective-use-of-design-patterns-in-software-development-exploring-the-visitor-pattern-part-2-c0e6fbdcf05f) |
| 3    | **Mastering the Observer Pattern**<br>Stay notified without micromanaging.                   | 👉 [Read Part 3](https://medium.com/@rafal.zowal1985/dancing-with-code-a-spirited-dive-into-the-observer-pattern-software-design-patterns-d05623692812)          |
| 4    | **Unveiling the Command Pattern**<br>Encapsulate your actions like a boss.                   | 👉 [Read Part 4](https://medium.com/@rafal.zowal1985/conquering-code-the-command-pattern-decoded-essential-design-patterns-in-software-development-e824f22a5ce8) |
| 5    | **Diving into the Interceptor Pattern**<br>Middleware magic, ninja style.                    | 👉 [Read Part 5](https://medium.com/illumination/boost-your-coding-efficiency-by-145-with-the-interceptor-pattern-a-developers-guide-part-5-fb266ba54a4a)        |
| 6    | **Crafting with the Factory Pattern**<br>Because not everything needs to be handcrafted.     | 👉 [Read Part 6](https://medium.com/@rafal.zowal1985/part-6-factory-pattern-3-times-more-productivity-boost-with-advanced-technique-9444153d05aa)                |
| 7    | **Building with the Builder Pattern**<br>Blueprints meet code — your structures made simple. | 👉 [Read Part 7](https://medium.com/@rafal.zowal1985/mastering-builder-pattern-guide-60c182f9cd61)                                                               |
| 8    | **Dependency Injection: The Art of Decoupling**<br>Coming soon — unplug your dependencies.   | 🔜 *Coming Soon*                                                                                                                                                 |


---

## How to Use This Repo

* Clone it and explore the pattern examples.
* Peek into the network library code to see patterns in action.
* Experiment by adding your own twists or extending patterns.
* Learn at your own pace with code and commentary side-by-side.

---

## 🚀 How to Use This Code: Dependency Injection Example

This project shows a fun, practical way to implement **Dependency Injection** in Swift, focusing on clean architecture and testability.

Here’s a quick guide to get started with the example:

---

### 1. Create your **AppDependencies** container

This struct holds all your configuration classes that register dependencies for your app.

```swift
import Foundation
import Core

struct AppDependencies {
    static let configs: [Config] = [
        SearchRepositoryConfig(),  // Add all your dependency configs here
    ]
}
```

---

### 2. Configure dependencies in your **AppDelegate**

Inside your app’s `AppDelegate`, call the global injector and pass your configs to register services at launch.

```swift
import Foundation
import SwiftUI
import Core

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GlobalContext.shared.configure(AppDependencies.configs) { }
        return true
    }
}
```

---

### 3. Define each dependency with a Config conforming struct

For example, the Search Repository config maps the protocol to the concrete implementation:

```swift
import Foundation
import Core

struct SearchRepositoryConfig: Config {
    func configure(_ injector: Injectorable) {
        injector.map(SearchRepositorible.self, SearchRepository())
    }
}
```

---

### 4. Implement the actual repository following your domain logic

```swift
import Foundation
import Network

protocol SearchRepositorible {
    func searchPhotos(search: String, page: String?) -> Observer<SearchResponse>
}

final class SearchRepository: SearchRepositorible  {
    func searchPhotos(search: String, page: String?) -> Observer<SearchResponse> {
        let path = "/rest"
        let request = RequestDataBuilder()
            .make(.path(path))
            .make(.method(.get))
            .make(.params(generateParams(search, page)))
        
        return ObserverFactory().executeRequest(request)
    }
}
```

---

### 5. Use injected dependencies in your ViewModel

Inject your dependency with the `@Inject` property wrapper and use it like this:

```swift
final class SearchViewModel: ObservableObject {
    @Inject private var repository: SearchRepositorible?

    private func fetchPhotos(_ search: String) {
        repository?.searchPhotos(search: search).complete { [weak self] result in
            if case let Result.success(response) = result {
                self?.photos = response?.photos ?? Photos.Empty
            }
            self?.searching = false
        }
    }
}
```

By default, the Environment file already comes with:

```swift
baseURL = "https://api.flickr.com/services"
```
So you're good to go right out of the box if you're testing with Flickr. But hey — flexibility is the name of the design pattern game. You can override this in your app layer if needed.

**Tip:** Try to check the code when you want to try to execute:
```swift
NetworkSetupCommand(configs: <#T##[any Config]?#>, enviroment: <#T##EnvironmentConfiguration#>, useCache: <#T##Bool#>).execute()
```

---

### Summary

* **Configure** your services in `AppDependencies`
* **Register** them in `AppDelegate`
* **Map** interfaces to implementations with Config objects
* **Inject** dependencies into consumers with `@Inject`
* **Use** them freely — decoupled, clean, and testable


--

## Feedback and Contributions

This is mostly a personal learning project, but I’m always happy to hear what you think or see your improvements. Feel free to open issues or pull requests!

---

## License

This project is for educational purposes and fun. Use it freely and share the joy of design patterns!
for comerial use - you must to get a permission

---

Thanks for stopping by!
Happy coding, and may your patterns always be elegant and your bugs easily hunted 🐞✨
