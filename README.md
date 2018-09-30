# CryptoTracker

iOS test project that retrieves BTC rates from CoinDesk API and displays it on an iOS app and a Watch companion.

## Summary

The project has been made using VIPER architecture. The file `RatesProtocols.swift` contains a general overview of the different entities and how they interact with each other.

For the interactors I have decided to split them for Local (Cache) and Remote (CoinDesk API).

For the WatchExtension I have use the same module replacing the ViewInterface for one for Watch, however, in a more complex UI a new presenter would be necessary.

For the TodayExtension the RemoteInteractor is used independently from the ViewController. This is not ideal.


NOTE: I had no previous experience with WatchKit apps nor Today Extension so forgive for any bad practices I may have taken.


### Resources used

The network layer `RequestManager` has been reused from previous projects but simplified for this project's needs. However it's 100% made by me. The same for Cacheable extension.

Aside from the `HTTPCode` file, everything else has been made exclusively for this project.


### WIP

There are several TODO's in the project about things that should be reworked next. 

- Refactor hardcoded currency into dynamic configurable value.
- Refactor UI to adapt to different devices (especially the Watch)
- Move hardcoded config values (URL's, Endpoints) to config plist file.
- Workout failure cases, retries and recovery.
