//
//  RequestLeaveViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestLeaveViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *reasonTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *fromDateTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *toDateTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *requestLeaveBtn;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*successMsg;
@property (weak, nonatomic) IBOutlet UIButton *fromDateBtn;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;



@end
