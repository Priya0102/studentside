

#import "StudentHostelViewController.h"
#import "HostelRoomRequestVC.h"
#import "RoomReqBtnViewController.h"
#import "HostelExitViewController.h"
#import "HotelExitListViewController.h"
#import "HostelChangeViewController.h"
#import "HostelChangeListVC.h"
#import "BaseViewController.h"
@interface StudentHostelViewController ()

@end

@implementation StudentHostelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}
-(void)navigatingFromLogin{
    
    NSString *status = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"status"];

    NSLog(@"status name==%@",status);
    
    NSString *reqstatus = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"requestedstatus"];
        NSLog(@"reqstatus name==%@",reqstatus);
    
    if ([status isEqualToString:@"2"] && [reqstatus isEqualToString:@"1"])
    {
        HostelRoomRequestVC *admin = [self.storyboard instantiateViewControllerWithIdentifier:@"roomRequest"];
        
        [self.navigationController pushViewController:admin animated:YES];
        NSLog(@"room request list....");
    }
    else
    {
        NSLog(@"room request btn clicked....");
                RoomReqBtnViewController *user = [self.storyboard instantiateViewControllerWithIdentifier:@"roomRequestBtn"];
        
                [self.navigationController pushViewController:user animated:YES];
    }
}
//- (IBAction)hostelChangeRequest:(id)sender {
//}
//- (IBAction)hostelExitBtnClicked:(id)sender {
//}


- (IBAction)roomRequestBtn:(id)sender {
     [self navigatingFromLogin];
}

- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"HOSTEL" localize];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    _hostelRoomReqLbl.text = [@"ROOM_REQUEST" localize];
    _hostelChangeReqLbl.text=[@"ROOM_CHANGE_REQUEST" localize];
    _myHostelLbl.text = [@"MY_HOSTEL" localize];
    _hostelExitLbl.text=[@"ROOM_EXITING_REQUEST" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    _hostelRoomReqLbl.text = [@"ROOM_REQUEST" localize];
    _hostelChangeReqLbl.text=[@"ROOM_CHANGE_REQUEST" localize];
    _myHostelLbl.text = [@"MY_HOSTEL" localize];
    _hostelExitLbl.text=[@"ROOM_EXITING_REQUEST" localize];
    
}



@end
