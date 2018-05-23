//
//  PickerView.h
//  Eshiksa
//
//  Created by Punit on 21/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIDatePicker
{
    //CGFloat Width;
}

@property (nonatomic,strong) UIDatePicker *datePicker;

-(void)ShowPicker:(CGFloat)Width;

@end
