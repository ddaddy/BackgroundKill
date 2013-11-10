BackgroundKill
==============

Kill iOS background apps to test restoration

While testing CoreBluetooth restoration from backgrounded apps, you need to have your app terminated by the OS.
Manually killing it voids the restoration.

This small app will slowly eat up memory to release all backgrounded apps so you can test out your restoration.
The process must be done slowly otherwise this app is quickly terminated by the OS before it kills any background apps.

On an iPad mini, this process takes about 35 seconds to complete.
On an iPhone 5s, this process takes about 25 seconds.

Usage
==============

Simply run the app, click the 'Kill All Background Apps' and wait for it to crash
