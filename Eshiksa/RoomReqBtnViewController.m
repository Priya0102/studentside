
#import "RoomReqBtnViewController.h"
#import "Constant.h"
#import "RoomReqBtn.h"
#import "RoomRequestBtnTVCell.h"
#import "HostelRoomRequestVC.h"
#import "BaseViewController.h"
#import "PickerView.h"
#import "Base.h"
@interface RoomReqBtnViewController ()

@end

@implementation RoomReqBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [fromDateTxtField setDateField:YES];

    _remarkArr=[[NSMutableArray alloc]init];
    _remarkRequestedStatusArr=[[NSMutableArray alloc]init];
    _remarkDateArr=[[NSMutableArray alloc]init];
    _remarkStatusArr=[[NSMutableArray alloc]init];
    _remarkGivenArr=[[NSMutableArray alloc]init];
    
    self.requestBtn.layer.masksToBounds=YES;
    self.requestBtn.layer.cornerRadius=8;
    
    [self.remark setDelegate:self];
    [fromDateTxtField setDelegate:self];
    
    [self parsingRoomRequest];
}

- (IBAction)requestBtnClicked:(id)sender {
    
    [self requestBtnParsing];
}
-(void)requestBtnParsing{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in requisition==%@",groupname);
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"requisition branchid ==%@",branchid);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"requisition orgid ==%@",orgid);
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"requisition cyear ==%@",cyear);

    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    
  
   // NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/hostel.php"];
    
    NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:hostel]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":str,
                                    @"tag": @"room_request",
                                    @"remark":self.remark.text,
                                    @"remark_date": fromDateTxtField.text,
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _successMsg=[maindic objectForKey:@"success_msg"];
            
            NSLog(@"tag==%@& success=%@  success msg=%@",_tag,_success,_successMsg);
            
            
            if([self.success isEqualToString:@"1"])
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                
                [alertView addAction:ok];
                self.remark.text=@"";
                fromDateTxtField.text=@"";
    
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Osps!" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                
                [alertView addAction:ok];
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            
            
        }
    }];
    

}
-(void)parsingRoomRequest
{
    
    [_remarkArr removeAllObjects];
    [_remarkDateArr removeAllObjects];
    [_remarkStatusArr removeAllObjects];
    [_remarkRequestedStatusArr removeAllObjects];
    [_remarkGivenArr removeAllObjects];

    
    //  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:keynote1]];
    
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);
    
    
    //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/hostel.php";
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:hostel]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                 @"instUrl":instUrl,
                                 @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag": @"room_request_list"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  remark  data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"change_list"];
            
            
            NSLog(@"ciculararr:%@",ciculararr);
            
            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"remark_date"]description];
                NSString *str2=[[temp objectForKey:@"status"]description];
                NSString *str3=[[temp objectForKey:@"requested_status"]description];
                 NSString *str4=[[temp objectForKey:@"remark"]description];
                
                
                NSLog(@"remark_date=%@  status=%@ requested_status=%@ remark=%@",str1,str2,str3,str4);
                
              
                
                RoomReqBtn *k1=[[RoomReqBtn alloc]init];
                k1.remarkDateStr=str1;
                k1.statusLblStr=str2;
                k1.remarkRequestedStatusStr=str3;
                k1.remarkStr=str4;
          
                [[NSUserDefaults standardUserDefaults] setObject:k1.statusLblStr forKey:@"status"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSUserDefaults standardUserDefaults] setObject:k1.remarkRequestedStatusStr forKey:@"requestedstatus"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [_remarkArr addObject:k1];
                
                [_tableview reloadData];
            }
            
        }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    //[task resume];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _remarkArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoomRequestBtnTVCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    RoomReqBtn *ktemp=[_remarkArr objectAtIndex:indexPath.row];
    
    cell.remarkDate.text=ktemp.remarkDateStr;
    cell.statusLbl.text=ktemp.statusLblStr;
    cell.requestedStatusLbl.text=ktemp.remarkRequestedStatusStr;
    cell.remark.text=ktemp.remarkStr;
    

    
    //ROOM REQUEST
    if ([cell.requestedStatusLbl.text isEqualToString:@"1"] && [cell.statusLbl.text isEqualToString:@"1"]){
        NSLog(@"Pending.......");
      /*  cell.statusBtnClicked.backgroundColor = [UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        cell.btnStatusLbl.text=@"P";
        cell.btnStatusLbl.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(35,45,30,30)];
        dot.image=[UIImage imageNamed:@"pending.png"];
        [cell.contentView addSubview:dot];
        //cell.imageView.image=[UIImage imageNamed:@"pending.png"];*/
        cell.hidden=YES;
    }
    
    if ([cell.requestedStatusLbl.text isEqualToString:@"1"] && [cell.statusLbl.text isEqualToString:@"2"]){
        NSLog(@"Approved.......");
        cell.statusBtnClicked.backgroundColor =[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        cell.btnStatusLbl.text=@"A";
        cell.btnStatusLbl.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        //UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(35,45,30,30)];
        cell.statusImg.image=[UIImage imageNamed:@"approved.png"];
        //[cell.contentView addSubview:dot];
        //cell.imageView.image=[UIImage imageNamed:@"approved.png"];
        
    }
    if ([cell.requestedStatusLbl.text isEqualToString:@"1"] && [cell.statusLbl.text isEqualToString:@"3"]){
        NSLog(@"Rejected.......");
        cell.statusBtnClicked.backgroundColor =[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];
   
        cell.btnStatusLbl.text=@"R";
        cell.btnStatusLbl.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];
        //UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(35,45,30,30)];
        cell.statusImg.image=[UIImage imageNamed:@"rejected.png"];
        //[cell.contentView addSubview:dot];
        //cell.imageView.image=[UIImage imageNamed:@"rejected.png"];
        
    }
   
    return cell;
}
//-(void)navigatingFromLogin{
//    
//    NSString *status = [[NSUserDefaults standardUserDefaults]
//                           stringForKey:@"status"];
//    NSLog(@"status name==%@",status);
//
//
//    if ([status isEqual:@"1"])
//    {
//        HostelRoomRequestVC *admin = [self.storyboard instantiateViewControllerWithIdentifier:@"roomRequest"];
//        
//        [self.navigationController pushViewController:admin animated:YES];
//        NSLog(@"room request list....");
//    }
//    else
//    {
//          NSLog(@"room request btn clicked....");
////        TeacherViewController *user = [self.storyboard instantiateViewControllerWithIdentifier:@"ToTeacher"];
////        
////        [self.navigationController pushViewController:user animated:YES];
//    }
//}
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
    
    _hostelRemarkLbl.text = [@"ROOM_HOSTEL_REMARK" localize];
    _dateLbl.text=[@"ROOM_HOSTEL_DATE" localize];
    _requestLbl.text=[@"ROOM_SAVE" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    _hostelRemarkLbl.text = [@"ROOM_HOSTEL_REMARK" localize];
    _dateLbl.text=[@"ROOM_HOSTEL_DATE" localize];
    _requestLbl.text=[@"ROOM_SAVE" localize];
}


@end
