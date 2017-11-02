
# iOS事件处理，响应者和响应链

## 概述

应用程序使用响应者对象来接收和处理事件，属于`UIResponder`类的实例对象都是响应者对象，常见的子类包括`UIView`、`UIViewController`和`UIApplication`。响应者接收到原始事件数据后，必须处理该事件或者将此事件转发给另一个响应者。当应用程序接收到一个事件时，UIKit会自动将该事件指向最合适的响应者对象，此响应者对象称为第一响应者。应用程序中不只存在一条响应者链，UIkit定义了如何将对象从一个响应者传递到下一个响应者的默认规则，但是我们可以随时通过覆盖响应者对象中的相应属性来更改这些规则。下图显示了应用程序中的默认响应者链，其界面包含一个label，一个text field，一个button和两个background view。如果text field没有处理某个事件，UIKit会将事件发送到text field的父视图对象，如果事件还是未被处理，UIKit会继续发送该事件到此视图的父视图，直到发送到window的根视图，然后响应者链从根视图转移到持有此根视图的视图控制器，再从视图控制器转移到window。如果window不处理这个事件，UIKit会将事件传递给`UIApplication`对象，如果该对象是`UIResponder`类的实例并且当前响应链不包含该对象，那么UiKit可能将该事件传递给应用程序的委托对象。

![图1-1](https://docs-assets.developer.apple.com/published/7c21d852b9/f17df5bc-d80b-4e17-81cf-4277b1e0f6e4.png)

## 确定事件的第一响应者

对于每种类型的事件，UIKit都会指定一个第一响应者，并首先将事件发送到该对象，第一响应者根据事件的类型而有所不同：

- 触摸事件(Touch events)：第一响应者是触摸所在屏幕位置的视图。
- 按压事件(Press events)：第一响应者是按压焦点所在的响应者。
- 摇晃事件(Shake-motion events)：第一响应者是由我们自己或者UIKit指定为第一响应者的对象。
- 远程控制事件(Remote-control events)：第一响应者是由我们自己或者UIKit指定为第一响应者的对象。
- 编辑菜单消息(Editing menu messages)：第一响应者是由我们自己或者UIKit指定为第一响应者的对象。

> #### 注意
与加速计、陀螺仪和磁力计相关的运动事件不遵循响应者链，Core Motion会将这些事件直接传递给您指定的对象。有关更多信息，可以参看[Core Motion Framework](https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/CoreServicesLayer/CoreServicesLayer.html#//apple_ref/doc/uid/TP40007898-CH10-SW27)。




