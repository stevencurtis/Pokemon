# Pokemon

## Criteria
* Use Swift, Xcode and the iOS Emulator
* Search Pokemon list
* Display the sprite of the Pokemon and the name on the list
* Display a detail screen of a chosen Pokemon's statistics (does not need to be all of them)
* Demonstrate use of version control
* Data persistence is optional (i.e. CoreData)
* The .git directory must be included in the solution
* Third-party frameworks can be used
* Third-party resources can be used, but should be referenced

## Mark scheme
* Technical ability (Code quality)
* Presentation skills (Design)
* Documentation (Sources and commenting)
* Overall solution (User experience)

# Installation
Download the Repo from the terminal or download from the download button above.

Once the folder has been downloaded to your machine, traverse to the folder and open `Pokemon.xcodeproj` in Xcode.

The solution uses Swift Package Manager. It is recommended that you reset the Cache through the menu `File>Swift Packages>Reset Package Caches`.

# Testing
To run unit tests use `⌘U` from within Xcode, or `Product>Test`.

# Deployment target
The target for this project is iOS13. 

iPhone is supported.

# Self-Review
## Code Quality
This solution uses MVVM-C, and showcases several *SOLID* principles.

## Presentation skills
This solution uses a `UITableView` with loading indicator, before displaying the detail screen. Lazy loading of images.

## Documentation
The vast majority of the code is considered to be self-documenting. I've used a number of frameworks, detailed in the references section below.

## Overall solution
The solution is stable, does not crash and has been tested. The Pokemon are stored in Core Data, so the App is functional without an Internet connection (if there is no Internet connection on first boot, the user is informed).

I've decided to use a programmatic interface rather than storyboards in this specific instance.

# References
This solution uses:
* My network manager [https://github.com/stevencurtis/NetworkManager](https://github.com/stevencurtis/NetworkManager)
* SDWebImage [https://github.com/SDWebImage/SDWebImage](https://github.com/SDWebImage/SDWebImage)

