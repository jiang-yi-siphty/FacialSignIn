# FacialSignIn

## Overview  
The FicialSignIn is a simple POC project to test the Ficial recoginition system.

## Orientation
I haven't include all dependent cocoapods in this repo. Please install pods before open the project.   

Please run below command in the terminal under project folder.    
 
     $pod install  
    
After install pods, please use Xcode to open the ```FacialSignIn.xcworkspace```.     

### Architeture

MVVM without RxSwift. This projest doesn't require many user interactives, thus, we only have simple data binding and events binding.

### Model
I use Codable Struct to build the data model. 

### ServerManager
We use simple URLSession to get json data in a couple of lines code. However, if so, the project will be hard to extend and test.   

The reason I create the ServerManager is for dependency injection, unit test and multi-services managerment.   

### Unit Test
Use XCTest framework for test ViewModel by feed mock data.   
Use XCTest framework for test API Web Service Call.  

### Q&A

1. Why use MVVM design pattern?   
	The MVC design pattern with Storyboard is not friendly for unit test. In order to do unit test, we need create the ViewController's instance in unit test class. The one of the MVVM's benefits is unit test friendly. 

2. Why use MVVM without reactive?   
	RxSwift is very popular now. Most of iOS MVVM projects adapted RxSwift. I know how to use it. I might create another feature branch to intrudce RxSwift into project in the future. The reason I didn't pick RxSwift with MVVM architecture is I want to try a new way to achieve MVVM.
	
### TODO:
1. On UI side, we need to implemnt UI design in the storyboard. We need create ViewController and ViewModel for these xib. 
2. The face detection can be happened in the live video stream. Currently, I just take the photo every 0.5 second and detect face, crop the face image. 
3. We need to encode the image into .jpg string, and embed the image string into request's body as json format. 
4. You can use dependency inject to use mock data to program NetworkManager and other parts.
3. Achive more unit test coverage.  

## Feedback

I would love to hear your feedback. File an issue,  send me an email: [jiang.yi@siphty.com](mailto:jiang.yi@siphty.com).


Enjoy!  
Yi Jiang
