## Icon Utils

Dart package that simplify integration with Icomoon service

## Usage

### Configure

<pre>
flutter_icons:
  output_dir: # Required. Path to folder that will contain dart file with icons.
  temp: # Required. Should be true if you are using free verison of icomoon.
  project: #Required. Name of the icomoon project.
  host: #Required. Host id it is stable if you are using paid version of icomoon
  class-name: #Optional. Name of created icons class. Default: AppIcons
<pre>

### Run command

For load ttf file and genetate dart class:

    flutter pub run intl flutter pub run icomoon:icomoon_download [--host {HOST}]
        
![Screenshot 2021-07-01 at 14 43 54](https://user-images.githubusercontent.com/17007214/124120221-3088be80-da7c-11eb-9f06-6bf65cb4ad5a.png)

