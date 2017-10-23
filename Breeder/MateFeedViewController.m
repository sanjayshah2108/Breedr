//
//  SecondViewController.m
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-16.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "MateFeedViewController.h"


@interface MateFeedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MateFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"petCellId"];
    
    //set cell labels and image data from server data
    
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return the number from the database
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 430.0;
}


@end

