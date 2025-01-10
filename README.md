# ONEAdMax Flutter Plugin 1.0.0

## Overview

ONE Store AdMax Flutter Plugin 1.0.0 is a service that delivers advertisements to users using the advertising system of ONE Store for products implemented in Android apps, and provides advertising revenue to developers. To bind this SDK, it is necessary to have products registered in the [ONE Store Developer Center](http://dev.onestore.co.kr/), and prior registration with [ONE AdMax](http://oneadmax.com) as a media platform is required.


## ONEAdMax SDK

### Installation

Run this command with flutter

```
$ flutter pub add flutter_onestore_inapp
```

Add dependency to pubspec.yaml
```
dependencies:
    one_admax_flutter: ^1.0.0
```

Set the Maven repository address in the project's gradle.

```groovy
repositories {
    maven { url 'https://repo.onestore.net/repository/onestore-sdk-public' }
}
```

Need to add `<queries>` to your `Androidmanifest.xml` file.

```xml
<manifest>
    <queries>
        <intent>
            <action android:name="com.onestore.iaa.intent.action.REWARD" />
        </intent>
    </queries>
    ...
    <application>
        ...
    </application>
</manifest>

```

Refer to the[[ONE AdMax Flutter guide]](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide)for more information

## Change Note
* 2025-01-10
    * Uploaded Project

# License
```
Copyright 2023 One store Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
