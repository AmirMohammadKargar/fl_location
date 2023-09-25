# fl_location


## Run Application

For running application localy you need have flutter sdk , android studio or xcode on your system.

to Run Application use command:
```
flutter run -t lib/src/main/main.dart
```

### Project Structure
<pre>
src
    |-> main
    |-> core
    |   |-> network
    |   |-> errors
    |   |-> theme
    |   |-> store
    |   |-> usecase
    |   |-> router
    |      
    |-> features
    |      |->auth
    |      |         |->data
    |      |         |->domain
    |      |         |->presentaion
    |      |->location
    |      |         |->data
    |      |         |->domain
    |      |->home
    |      |         |->presentaion
    |      
    |-> shared
    |      |->widgets
    |      |->extensions
    |      |->utils
    |      |->constant
</pre>