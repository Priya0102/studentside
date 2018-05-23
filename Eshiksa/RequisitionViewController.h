//
//  RequisitionViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface RequisitionViewController : UIViewController<UIScrollViewDelegate,NIDropDownDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *requisitionBtnSelect;
    
    NIDropDown *dropDown1;
}
@property (weak, nonatomic) IBOutlet UITextField *requisitionTitle;
@property (weak, nonatomic) IBOutlet UITextField *investmentAmt;
@property (weak, nonatomic) IBOutlet UITextField *requisitionType;
@property (weak, nonatomic) IBOutlet UITextField *requisitionDetails;
- (IBAction)registerRequisitionBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reisterReqBtn;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*successMsg;
@end
