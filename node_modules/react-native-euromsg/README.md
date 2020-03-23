
# react-native-euromsg
[![npm version](https://badge.fury.io/js/react-native-euromsg.svg)](//npmjs.com/package/react-native-euromsg)
# ***This is a work in progress:hourglass_flowing_sand:***
## Getting started

`$ npm install react-native-euromsg --save`

### Mostly automatic installation

`$ react-native link react-native-euromsg`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-euromsg` and add `RNEuromsg.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNEuromsg.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.bnzl.RNEuromsg.RNEuromsgPackage;` to the imports at the top of the file
  - Add `new RNEuromsgPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-euromsg'
  	project(':react-native-euromsg').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-euromsg/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-euromsg')
  	```


## Usage
```javascript
import RNEuromsg from 'react-native-euromsg';

// TODO: What to do with the module?
RNEuromsg;
```
  
