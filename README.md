# CryptoTracker

iOS test project that retrieves BTC rates from CoinDesk API and displays it on an iOS app and a Watch companion. Project also includes a TodayExtension.

## Summary

The project has been made using VIPER architecture. The file `RatesProtocols.swift` contains a general overview of the different entities and how they interact with each other.

For the interactors I have decided to split them for Local (Cache) and Remote (CoinDesk API).

For the WatchExtension I have use the same module replacing the ViewInterface for one for Watch, however, in a more complex UI a new presenter would be necessary.

For the TodayExtension the RemoteInteractor is used independently from the ViewController. This is not ideal.


NOTE: I had no previous experience with WatchKit apps nor Today Extension so forgive for any bad practices I may have taken.

### Considerations

- RequestManager is a simple library to create HTTP requests without much overhead. See: https://github.com/gzafra/SimpleRequestManager

- For the project structure I have decided to split it in 3 layers (presentation, domain, data) and within these, for the specific modules and one for common / shared content.

- For the UI I have decided to use programmatically created views as UI is simple and it allows for easier testing.


### WIP

There are several TODO's in the project about things that should be reworked next. 

- Refactor UI to adapt to different devices (especially the Watch)

- Move hardcoded config values (URL's, Endpoints) to config plist file.

- Workout failure cases, retries and recovery.

