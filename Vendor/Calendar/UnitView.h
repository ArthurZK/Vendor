/*!
 @header    UnitView.h
 @abstract  添加成员animationView
 @author    丁磊
 @version   1.0.0 2014/05/28 Creation
 */

#import <UIKit/UIKit.h>

@interface UnitView : UIView

/*
    添加一个成员
    icon：成员头像
    name：成员名字
 */
- (void) addNewUnit:(NSString *)icon withName:(NSString *)name;

@end
