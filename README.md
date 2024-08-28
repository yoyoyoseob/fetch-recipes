# fetch-recipes
iOS Coding Challenge for Fetch

API: 
* https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
* https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID

Components:
* List view displaying desserts sorted *alphabetically*
* Detail view displaying *meal name*, *cooking instructions*, *ingredients/measurements*

Constraints:
* Swift Concurrency (do not use Combine)
* Filter null/empty values from the list
* Basic HIG (Human Interface Guidelines)
* Latest version of Xcode (v15+)
* SwiftUI
* Public Repository

Architecture:
* SwiftUI
* MVVM
* Dependency Injection via EnvironmentObject + Constructor Injection
