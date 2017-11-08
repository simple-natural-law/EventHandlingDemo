
# iOS响应者、响应者链和事件处理

## 概述

应用程序使用响应者对象来接收和处理事件，属于`UIResponder`类的实例对象都是响应者，常见的子类包括`UIView`、`UIViewController`和`UIApplication`。响应者接收到原始事件后，必须处理该事件或者将此事件转发给另一个响应者。当应用程序接收到一个事件时，UIKit会自动将该事件指向最合适的响应者对象，此响应者称为第一响应者，第一响应者会将未处理的事件传递给处于激活状态的响应者链中的的下一个响应者对象。应用程序中不存在单一的响应者链，UIkit定义了如何将对象从一个响应者传递到下一个响应者的默认规则，我们可以随时通过覆盖响应者对象中的`nextResponder`属性来更改这些规则。下图显示了应用程序中的默认响应者链，其界面包含一个label，一个text field，一个button和两个background view。如果text field没有处理触摸事件，UIKit会将事件发送到text field的父视图对象，如果事件还是未被处理，UIKit会继续发送该事件到此视图的父视图，直到发送到window的根视图，然后响应者链从根视图转移到持有此根视图的视图控制器，再从视图控制器转移到window。如果window不处理这个事件，UIKit会将事件传递给`UIApplication`对象。如果应用程序的委托对象是`UIResponder`类的实例并且响应者链中还不包含该对象，那么UiKit可能将该事件传递给应用程序的委托对象。

![图1-1](https://docs-assets.developer.apple.com/published/7c21d852b9/f17df5bc-d80b-4e17-81cf-4277b1e0f6e4.png)

## 确定事件的第一响应者

对于每种类型的事件，UIKit都会指定一个第一响应者，并首先将事件发送给该对象，第一响应者根据事件的类型而有所不同：

- 触摸事件(Touch events)：第一响应者是触摸点所在的视图。
- 按压事件(Press events)：第一响应者是有焦点的响应者。
- 摇晃运动事件(Shake-motion events)：第一响应者是由我们自己(或者UIKit)指定为第一响应者的对象。
- 远程控制事件(Remote-control events)：第一响应者是由我们自己(或者UIKit)指定为第一响应者的对象。
- 编辑菜单消息(Editing menu messages)：第一响应者是由我们自己(或者UIKit)指定为第一响应者的对象。

> **注意**：与加速计、陀螺仪和磁力计相关的运动事件不遵循响应者链，Core Motion会将这些事件直接传递给我们指定的对象。有关更多信息，可以参看[Core Motion Framework](https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/CoreServicesLayer/CoreServicesLayer.html#//apple_ref/doc/uid/TP40007898-CH10-SW27)。

控件使用动作消息直接与其关联的目标对象进行通信。当用户与控件交互时，控件会调用其`target`对象的`action`方法——换句话说，控件会向目标对象发送一个动作消息。动作消息不属于事件，但是它也可以使用响应者链。当控件的`target`对象为`nil`时，UIKit会从`target`对象开始顺着响应链寻找，直到找到实现了对应`action`方法的对象。例如，编辑菜单就使用这种方式去搜索实现了方法名为`cut:`、`copy:`、`paste:`的响应者对象。

如果一个视图附加有手势识别器，手势识别器会先于视图接收到触摸和按压事件。如果所有视图的手势识别器都无法识别它们的手势，那么事件就会被传递给视图进行处理。如果视图没有处理它们，UIKit会继续沿着响应者链传递事件。有关使用手势识别器处理事件的更多信息，可以参看[Handling UIKit Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures)。


## 更改响应者链

可以通过覆写响应者对象的`nextResponder`属性来更改响应者链，许多UIKit类已经覆盖此属性并返回了特定的对象。

- `UIView`对象：如果这个视图是视图控制器的根视图，那么下一个响应者就是这个视图控制器；否则，下一个响应者就是它的父视图。
- `UIViewController`对象：如果视图控制器的视图是window的根视图，则下一个响应者就是window；如果视图控制器是被另一个视图控制器呈现的，则下一个响应者是这个呈现视图控制器。
- `UIWindow`对象：window的下一个响应者是`UIApplication`对象。
- `UIApplication`对象：当应用程序的委托对象是`UIResponder`类的实例，而不是视图、视图控制器或者应用程序对象本身时，其下一个响应者就是应用程序的委托对象。



## 触摸事件(Touch events)

### 如何确定触摸事件的第一响应者

触摸事件的第一响应者是触摸位置所在的视图，UIKit使用基于视图的命中测试来确定触摸事件发生的位置。具体来说，UIKit将触摸位置与视图层中的视图对象的边界进行比较。`UIView`的`hitTest:withEvent:`方法会遍历视图层，寻找包含指定触摸位置的最深的子视图，这个视图就会成为触摸事件的第一响应者。

`hitTest:withEvent:`方法会遍历当前视图层，并调用每个子视图的`pointInside:withEvent:`方法来判断子视图的边界是否包含触摸点。如果`pointInside:withEvent:`方法返回`YES`，则会同样遍历子视图的视图层，直到找到包含触摸点的最上层视图。如果视图不包含该触摸点，那么此视图层分支会被忽略掉。因此，我们可以通过覆写`hitTest:withEvent:`方法来隐藏子视图中的触摸事件。此方法会忽略掉被隐藏、已禁用用户交互或者`alpha`小于**0.01**的视图对象。在确定命中视图时，此方法不会考虑视图的内容。因此，即使触摸点位于该视图内容的透明部分，仍然可以确定命中此视图。当视图的`clipsToBounds`的属性为`NO`时，如果触摸点在视图的边界之外，即使它的子视图恰好包含该触摸点，但子视图超出了视图的边界，`hitTest:withEvent:`方法也不会返回命中了此视图。

UIKit会将每个触摸事件永久指定给包含触摸位置的最上层视图，当触摸开始时，UIKit会为每个触摸事件创建一个`UITouch`对象，直到触摸结束之后才会释放`UITouch`对象。随着触摸位置或其他参数的改变，UIKit会使用新信息更新`UITouch`对象，唯一不变的属性是触摸事件所属的`view`。即使触摸位置移动到触摸事件所属的原始视图之外，触摸事件所属视图也不会改变。

### 处理触摸事件

响应者对象都是`UIResponder`类的实例，在处理特定类型的事件时，系统会调用响应者对象相应的方法去回应事件，响应者必须覆写实现相应的方法。为了处理触摸事件，响应者对象需要实现`touchesBegan:withEvent:`、`touchesMoved:withEvent:`和`touchesEnded:withEvent:`方法中的一个或者多个。UIKit确定触摸事件的第一响应者之后，如果这个响应者类覆写实现了`touchesBegan:withEvent:`、`touchesMoved:withEvent:`和`touchesEnded:withEvent:`方法中的一个或者多个，那么当触摸开始发生时，系统会调用响应者对象的`touchesBegan:withEvent:`方法去回应触摸事件。当触摸位置移动时，会调用响应者对象的`touchesMoved:withEvent:`方法去回应，当触摸结束时，会调用`touchesEnded:withEvent:`方法去回应。如果这几个方法一个都没有被实现，那么UIKit会沿着默认的响应者链去传递触摸事件。如果响应者链中有响应者实现了前述方法，那么该响应者对象就会去处理传递来的触摸事件。否则，该触摸事件就不会被处理。

系统还可以随时取消正在进行的触摸序列，当有来电打断应用程序时，UIKit会调用响应者的`touchesCancelled:withEvent:`方法去通知响应者当前触摸事件已经被系统取消了。

![图4-1 触摸事件的阶段](https://docs-assets.developer.apple.com/published/7c21d852b9/08b952fe-6f46-41eb-8b8a-4830c1d48842.png)

`touchesBegan:withEvent:`、`touchesMoved:withEvent:`、`touchesEnded:withEvent:`和`touchesCancelled:withEvent:`方法分别对应于触摸事件处理过程的不同阶段。当手指(或Apple Pencil)触摸屏幕时，UIKit会创建一个`UITouch`对象，将触摸点设置为相应的屏幕坐标点，并将其`phase`属性值设为`UITouchPhaseBegan`。当手指在屏幕上移动时，UIKit会更新触摸位置，并将`UITouch`对象的`phase`属性值改变为`UITouchPhaseMoved`。当用户从屏幕上移开手指时，UIKit会将`phase`属性值改变为`UITouchPhaseEnded`，触摸序列结束。当触摸事件被系统取消时，UIKit会将`phase`属性值改变为`UITouchPhaseCancelled`。

> **重要**：在默认配置下，当多个手指同时触摸视图时，视图也只会接收与事件关联的第一个`UITouch`对象。要接收额外的触摸事件，必须将视图的`multipleTouchEnabled`属性设为`YES`。


## 摇晃-运动事件


当系统监听到摇晃事件时，会寻找摇晃事件的第一响应者，并将该摇晃事件传递给第一响应者去处理，而摇晃事件的第一响应者是被我们自己(或者UIKit)指定为第一响应者的对象。覆写响应者对象的`canBecomeFirstResponder`方法并返回`YES`，同时调用其`becomeFirstResponder`方法，该响应者对象就会被指定为第一响应者。要对摇晃事件进行处理，响应者对象还需要至少覆写实现`motionBegan:withEvent:`和`motionEnded:withEvent:`方法中的一个。当摇晃事件开始发生时，系统会调用响应者对象的`motionBegan:withEvent:`方法去回应摇晃事件。当摇晃事件结束时，系统会调用响应者对象的`motionEnded:withEvent:`方法回应。如果第一响应者没有处理，那么UIKit会沿着响应者链传递该摇晃事件。

当我们不需要再对摇晃事件进行处理时，需要调用当前响应者对象的`resignFirstResponder`方法注销其第一响应者身份。

**注意：iOS 11(其他系统版本没试)下通过代码实践发现，自定义一个响应者对象，覆写`canBecomeFirstResponder`、`motionBegan:withEvent:`和`motionEnded:withEvent:`方法，在视图控制器的`viewDidAppear:`方法中调用该响应者对象`becomeFirstResponder`方法返回`YES`后，响应者对象还是无法接收到摇晃事件。**


## 远程控制事件

远程控制事件主要是由耳机线控操作触发的，它和音频播放有关。远程控制事件有以下几种类型：

- `UIEventSubtypeRemoteControlPlay`：播放事件，在暂停状态下，按耳机线控中间按钮一下触发。
- `UIEventSubtypeRemoteControlPause`：暂停事件，在播放状态下，按耳机线控中间按钮一下触发。
- `UIEventSubtypeRemoteControlStop`：停止事件
- `UIEventSubtypeRemoteControlTogglePlayPause`：播放或暂停切换，在播放或暂停状态下，按耳机线控中间按钮一下触发。
- `UIEventSubtypeRemoteControlNextTrack`：下一曲，按耳机线控中间按钮两下触发。
- `UIEventSubtypeRemoteControlPreviousTrack`：上一曲，按耳机线控中间按钮三下触发。
- `UIEventSubtypeRemoteControlBeginSeekingBackward`：快退开始，按耳机线控中间按钮三下不要松开触发。
- `UIEventSubtypeRemoteControlEndSeekingBackward`：快退停止，按耳机线控中间按钮三下到了快退的位置松开触发。
- `UIEventSubtypeRemoteControlBeginSeekingForward`：快进开始，按耳机线控中间按钮两下不要松开触发。
- `UIEventSubtypeRemoteControlEndSeekingForward`：快进停止，按耳机线控中间按钮两下到了快进的位置松开触发。

接收远程控制事件首先需要在应用程序启动完成后调用应用程序中唯一的`UIApplication`对象的`beginReceivingRemoteControlEvents`方法启用远程控制事件接收。要对远程控制事件进行处理，需要响应者对象覆写实现`remoteControlReceivedWithEvent:`方法，如果这个响应者对象不是`UIApplication`类或者`UIViewController`类的实例，还需要指定该响应者对象为第一响应者。要停止接收远程控制事件，需要调用应用程序中唯一的`UIApplication`对象的`endReceivingRemoteControlEvents`方法。


## Demo

示例代码下载：https://github.com/zhangshijian/EventHandlingDemo.git






