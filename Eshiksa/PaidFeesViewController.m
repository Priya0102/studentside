//
//  PaidFeesViewController.m
//  Eshiksa
//
//  Created by Punit on 07/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.


#import "PaidFeesViewController.h"
#import "Constant.h"
#import "PaidFees.h"
#import "PaidFeesTableViewCell.h"
#import "BaseViewController.h"
#import "Base.h"
@interface PaidFeesViewController ()

@end

@implementation PaidFeesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [_tableview setSeparatorColor:[UIColor clearColor]];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _billNumberArr=[[NSMutableArray alloc]init];
    _createdDateArr=[[NSMutableArray alloc]init];
    _feesNameArr=[[NSMutableArray alloc]init];
    _payStatusArr=[[NSMutableArray alloc]init];
    _feesAmountArr=[[NSMutableArray alloc]init];
    _fineAmountArr=[[NSMutableArray alloc]init];
    _paidAmountArr=[[NSMutableArray alloc]init];
    _paidArr=[[NSMutableArray alloc]init];
    
    [self parsingPaidFees];
    
}

-(void)parsingPaidFees{
    
    [_billNumberArr removeAllObjects];
    [_createdDateArr removeAllObjects];
    [_feesNameArr removeAllObjects];
    [_payStatusArr removeAllObjects];
    [_feesAmountArr removeAllObjects];
    [_fineAmountArr removeAllObjects];
    [_paidAmountArr removeAllObjects];
    [_paidArr removeAllObjects];
   


    //  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:abc]];
    
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"circular password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);

    
    //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo_ios/fees_v2.php";

    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:fees_v2]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url": urlstr,
                                    @"tag":@"paid"
                                    };
   
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  paid fees data:%@",maindic);
                       
            NSArray *ciculararr=[maindic objectForKey:@"paid_fees"];
            NSLog(@"paid_fees0000:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                _noSchedule = [[UITextView alloc]initWithFrame:
                               CGRectMake(60, 200, 400, 300)];
                [_noSchedule setText:@"No paid fees data available.."];
                [_noSchedule setTextColor:[UIColor grayColor]];
                [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:13]];
                _noSchedule.delegate =self;
                [self.view addSubview:_noSchedule];
                
            }
            else {
                
       for (NSArray *coverUrlArray in ciculararr) {
           
            for(NSDictionary *temp in coverUrlArray)
            {
                NSString *str1=[temp objectForKey:@"bill_number"];
                NSString *str2=[[temp objectForKey:@"created_date"]description];
                NSString *str3=[[temp objectForKey:@"fees_name"]description];
                NSString *str4=[[temp objectForKey:@"pay_status"]description];
                NSString *str5=[[temp objectForKey:@"fees_amount"]description];
                NSString *str6=[[temp objectForKey:@"fine_amount"]description];
                NSString *str7=[[temp objectForKey:@"paid_amount"]description];
                
                NSLog(@"bill_number=%@  title=%@ publish_date=%@ publish_todate=%@",str1,str2,str3,str4);
                if (([(NSString*)str1 isEqual: [NSNull null]])) {
                    // Showing AlertView Here
                }else {
                    
                PaidFees *k1=[[PaidFees alloc]init];
                k1.billNumStr=str1;
                k1.createdDateStr=str2;
                k1.feesNameStr=str3;
                k1.payStatusStr=str4;
                k1.feesAmountStr=str5;
                k1.fineAmountStr=str6;
                k1.paidAmtStr=str7;
//
                [_paidArr addObject:k1];
                
                [_tableview reloadData];
            }
           }
          }
         }
        }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _paidArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaidFeesTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PaidFees *ktemp=[_paidArr objectAtIndex:indexPath.row];
    
    cell.billNumber.text=ktemp.billNumStr;
    cell.createdDate.text=ktemp.createdDateStr;
    cell.feesName.text=ktemp.feesNameStr;
    cell.payStatus.text=ktemp.payStatusStr;
    cell.feesAmount.text=ktemp.feesAmountStr;
    cell.fineAmount.text=ktemp.fineAmountStr;
    cell.paidAmount.text=ktemp.paidAmtStr;
    //cell.invoiceBtn.tag=ktemp.invoiceBtnStr;
    
    return cell;
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"PAID_FEES" localize];
}

@end
