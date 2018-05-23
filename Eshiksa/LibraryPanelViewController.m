//
//  LibraryPanelViewController.m
//  Eshiksa
//
//  Created by Punit on 27/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.


#import "LibraryPanelViewController.h"
#import "Constant.h"
#import "LibraryPanel.h"
#import "LibraryPanelTableViewCell.h"
#import "BaseViewController.h"
@interface LibraryPanelViewController ()

@end

@implementation LibraryPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableview setSeparatorColor:[UIColor clearColor]];
    
    _nameArr=[[NSMutableArray alloc]init];
    _isbnArr=[[NSMutableArray alloc]init];
    _authorArr=[[NSMutableArray alloc]init];
    _editionArr=[[NSMutableArray alloc]init];
    _publisherArr=[[NSMutableArray alloc]init];
    _numberOfBooksArr=[[NSMutableArray alloc]init];
    _booksAvailableArr=[[NSMutableArray alloc]init];
    _bookArr=[[NSMutableArray alloc]init];
    
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingCircular];
}
-(void)parsingCircular
{
    
    [_nameArr removeAllObjects];
    [_isbnArr removeAllObjects];
    [_authorArr removeAllObjects];
    [_editionArr removeAllObjects];
    [_publisherArr removeAllObjects];
    [_numberOfBooksArr removeAllObjects];
    [_booksAvailableArr removeAllObjects];
    [_bookArr removeAllObjects];
    
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
    
    NSString *bookid = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"bookId"];
    NSLog(@"get btn clickedlibrary bookid ==%@",bookid);
    
    NSString *bookName = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"bookName"];
    NSLog(@"get btn bookName  ==%@",bookName);
    
    NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/library.php";
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":@"erpeshik_esh_slave_edemo_new",
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url": @"http://shop.eshiksa.com/appAPI_v2_edemo/library.php",
                                    @"tag": @"books",
                                    @"category":bookid,
                                    @"book_name":bookName
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  lib_books data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"lib_books"];
            
            
            NSLog(@"ciculararr:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                _noSchedule = [[UITextView alloc]initWithFrame:
                               CGRectMake(80, 200, 400, 300)];
                [_noSchedule setText:@"No Data found..."];
                [_noSchedule setTextColor:[UIColor grayColor]];
                [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:16]];
                _noSchedule.delegate =self;
                [self.view addSubview:_noSchedule];
                
            }
            else {
            
            
            for(NSDictionary *temp in ciculararr)
            {
               // NSString *str1=[[temp objectForKey:@"id"]description];
                NSString *str2=[[temp objectForKey:@"isbn"]description];
                NSString *str3=[temp objectForKey:@"name"];
                NSString *str4=[temp objectForKey:@"author"];
                NSString *str5=[[temp objectForKey:@"edition"]description];
                NSString *str6=[[temp objectForKey:@"publisher"]description];
                NSString *str7=[temp objectForKey:@"no_of_books"];
                NSString *str8=[temp objectForKey:@"books_available"];
                
                NSLog(@"isbn=%@ name=%@ author=%@ edition=%@  publisher=%@ no_of_books=%@ books_available=%@",str2,str3,str4,str5,str6,str7,str8);
                
                
                LibraryPanel *k1=[[LibraryPanel alloc]init];
              
                k1.isbnStr=str2;
                k1.nameStr=str3;
                k1.authorStr=str4;
                k1.editionStr=str5;
                k1.publisherStr=str6;
                k1.numberOfBooksStr=str7;
                k1.booksAvailableStr=str8;
           
                [_bookArr addObject:k1];
                
                [_tableview reloadData];
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
    return _bookArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryPanelTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    LibraryPanel *ktemp=[_bookArr objectAtIndex:indexPath.row];
    
    cell.name.text=ktemp.nameStr;
    cell.isbn.text=ktemp.isbnStr;
    cell.author.text=ktemp.authorStr;
    cell.edition.text=ktemp.editionStr;
    cell.publisher.text=ktemp.publisherStr;
    cell.numberOfBooks.text=ktemp.numberOfBooksStr;
    cell.booksAvailable.text=ktemp.booksAvailableStr;
    
    
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
    self.navigationItem.title = [@"BOOKS_LIBRARY" localize];
}

@end
