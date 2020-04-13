# PP-Challenge

https://github.com/Pay-Baymax/MobileDeveloperChallenge

## Functional Requirements:
- [x] Exchange rates must be fetched from: https://currencylayer.com/documentation  
- [x] Use free API Access Key for using the API
- [x] User must be able to select a currency from a list of currencies provided by the API(for currencies that are not available, convert them on the app side. When converting, floating-point error is accpetable)
- [x] User must be able to enter desired amount for selected currency
- [x] User should then see a list of exchange rates for the selected currency
- [x] Rates should be persisted locally and refreshed no more frequently than every 30 minutes (to limit bandwidth usage)

## Install
If your don't have cocoapods installed on your machine, see [here](https://guides.cocoapods.org/using/getting-started.html). After you have installed cocoapods go to the project directory, and run
```
pod install
```
then open the workspace file.

## Other
An unpaid apple devloper account can not run on real device which iOS version is iOS 13.3.1. see [detail](https://forums.developer.apple.com/thread/128987).

**Thanks for your time to review my code :D**
