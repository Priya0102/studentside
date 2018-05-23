//
//  AttendanceViewController.h
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "DropdownMenuSegue.h"
@interface AttendanceViewController : UIViewController<UIScrollViewDelegate,NIDropDownDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *courseBtnSelect;
    IBOutlet UIButton *batchBtnSelect;
    IBOutlet UIButton *sectionBtnSelect;
    IBOutlet UIButton *subjectBtnSelect;
    
    
    
    NIDropDown *dropDown1,*dropDown2,*dropDown3,*dropDown4;
    
}

@property (weak, nonatomic) IBOutlet UITextField *txtCalender;
@property (weak, nonatomic) IBOutlet UIView *containerView;
//-(void)rel;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSString *result;

@property(nonatomic,strong)NSArray *patternImagesArray;
@property (weak, nonatomic) IBOutlet UILabel *message;

//@property (nonatomic, retain) NSString *city_str;

@property(nonatomic,strong)NSArray *labelArray;
@property (weak, nonatomic) IBOutlet UIImageView *animationView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *contentview;

@property (strong,nonatomic) NSString *role_id;

@property (strong,nonatomic) NSString *city_str,*startDatestr,*endDatestr,*eventNamestr,*event_idstr,*other_eventsstr,*startTimestr,*endTimestr;

@property (strong,nonatomic) NSString *courseName;
@property (strong,nonatomic) NSString *batchName;
@property int maximumZoomScale;
@property int minimumZoomScale;

//@property(nonatomic,retain)OpeningViewController *ovc;
//@property DateTime *d;

@property (strong, nonatomic) IBOutlet UITextField *eventType;

@property (strong, nonatomic) IBOutlet UITextField *city;




@property (retain, nonatomic) IBOutlet UIButton *cityBtnSelect;
//- (IBAction)cityselectClicked:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *eventBtnSelect;
//- (IBAction)eventselectClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *citylbl;
@property (strong, nonatomic) IBOutlet UILabel *eventname;
@property (strong, nonatomic) IBOutlet UILabel *eventtypeid;
@property (strong, nonatomic) IBOutlet UILabel *other_events;
@property (strong, nonatomic) IBOutlet UILabel *venueLbl;

@property (weak,nonatomic) UIViewController *currentViewController;


@end
