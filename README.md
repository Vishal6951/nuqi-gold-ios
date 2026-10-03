# NuqiGold iOS SDK

The Nuqi gold experience — live price, buy, sell, portfolio — as one screen you drop into
your app after your own login. This release runs on demo data, so no backend, keys or
special Apple capabilities are needed.

## Requirements

- Xcode 27.1 or later
- iOS 16.0 or later (simulator or iPhone)

## 1 · Add the package

Xcode → **File → Add Package Dependencies…** → enter

```
https://github.com/stalwartszen/nuqi-gold-ios
```

Dependency Rule **Exact Version 1.0.0** → **Add Package** → tick **NuqiGold** for your app
target.

> Private repository? Add your GitHub account first: Xcode → Settings → Accounts.

## 2 · Set the deployment target

App target → General → **Minimum Deployments → iOS 16.0**.

## 3 · Open the SDK after your login

The SDK becomes your app's main screen once the customer has logged in. Replace
`YourLoginView` with your own login screen.

### SwiftUI

```swift
import SwiftUI
import NuqiGold

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @StateObject private var nuqi = NuqiSession.demo()

    var body: some View {
        if isLoggedIn {
            // The back button on the SDK's dashboard calls onExit — use it to log out.
            NuqiRootView(session: nuqi, onExit: { isLoggedIn = false })
        } else {
            YourLoginView(onLogin: { isLoggedIn = true })
        }
    }
}
```

### UIKit

After a successful login, make the SDK the window's root:

```swift
import UIKit
import SwiftUI
import NuqiGold

final class LoginViewController: UIViewController {
    private let nuqi = NuqiSession.demo()

    func loginSucceeded() {
        guard let window = view.window else { return }
        // Capture the window, not self: this controller is released once it stops being root.
        let root = NuqiRootView(session: nuqi, onExit: { [weak window] in
            window?.rootViewController = LoginViewController()
        })
        window.rootViewController = UIHostingController(rootView: root)
    }
}
```

### Only one journey

Instead of the full dashboard:

```swift
NuqiFeatureView(.buy, session: nuqi)        // or .sell, .portfolio
```

## 4 · Run

Build and run → log in → the gold dashboard opens. Buy, sell and portfolio all work on demo
data. Face ID is simulated in this release, so no `Info.plist` entry is needed.

## Troubleshooting

| Problem | Fix |
|---|---|
| `No such module 'NuqiGold'` | The package is not added to your app target (step 1). |
| "compiled with Swift … cannot be imported" | Your Xcode is older than 27.1. Update Xcode, or ask us for a build for your version. |
| Package download fails | Private repository: add your GitHub account in Xcode → Settings → Accounts. |
| `NuqiSession` / `NuqiRootView` not found | Add `import NuqiGold` at the top of the file. |
