# react-native-universal-pedometer

React Native pedometer support for iOS version 8.0 and higher and Android. The module is CMPedometer wrapper. More info about CMPedometer can be found in https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CMPedometer_class/

#### _Note_

- Currently typescript is supported.

### Installation

1. `npm install --save @JWWon/react-native-universal-pedometer`

> or `yarn add JWWon/react-native-universal-pedometer`

2. `react-native link @JWWon/react-native-universal-pedometer`

> It will automatically do all necessary settings

##### iOS Configuration

add **NSMotionUsageDescription** on `ios/<your-project>/info.plist`

```
// info.plist
<dict>
	...
	<key>NSMotionUsageDescription</key>
	<string></string>
</dict>
```

### General Usage

```js
import Pedometer from '@JWWon/react-native-universal-pedometer';
```

or

```js
var Pedometer = require('@JWWon/react-native-universal-pedometer');
```

### Methods

| Method Name                      | Arguments                                                    | Notes                                                        |
| -------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `isStepCountingAvailable`        | callback: `Callback`                                         |                                                              |
| `isDistanceAvailable`            | callback: `Callback`                                         |                                                              |
| `isFloorCountingAvailable`       | callback: `Callback`                                         |                                                              |
| `isPaceAvailable`                | callback: `Callback`                                         |                                                              |
| `isCadenceAvailable`             | callback: `Callback`                                         |                                                              |
| `startPedometerUpdatesFromDate`  | date: `Date.getTime()`, listener: `Listener`                 | start tracking from current time                             |
| `queryPedometerDataBetweenDates` | startDate: `Date.getTime()`, endDate: `Date.getTime()`, listener: `Listener` | query pedometer data from selected date to other selected date |
| `stopPedometerUpdates`           |                                                              | stop pedometer updates                                       |

### Types

| Type Name                 | Interface                                                    |
| ------------------------- | ------------------------------------------------------------ |
| `PedometerInterface`      | `{ startDate: nubmer; endDate: number; numberOfSteps: number; distance: number; }` |
| `PedometerErrorInterface` | `{ code: number; message: string; }`                         |
| `Callback`                | `(error: string or null, avaliable: boolean) => any`         |
| `Listener`                | `(data: PedometerInterface or PedometerErrorInterface) => any` |

