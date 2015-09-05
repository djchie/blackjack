# Setting your app for nw

Go to your application root folder
Set up package.json and be sure to specify the main property

- Example
```json
  { 
    "name": "blackjack", 
    "main": "index.html", 
    "window": { 
      "toolbar": false, 
      "width": 800, 
      "height": 600 
    } 
  }
```
`zip -r app.nw *`

it must be named `app.nw`



#Working with nw

Download the build of NW.js

Unzip the downloaded file, and go into the folder contain nwjs.app

Right-click on the nwjs.app and choose Show Package Contents from the contextual menu

Navigate to nwjs.app/Content/Resources

Place your app.nw file inside this Resources folder

Modify the file at `nwjs.app/Content/Info.plist` so that `<key>CFBundleName</key>` is associated with `<string>NameOfYourChoice</string>`. (This defines the name of the application menu.)

Rename the `nwjs.app` as `NameOfYourChoice.app`