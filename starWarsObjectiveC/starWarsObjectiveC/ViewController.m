//
//  ViewController.m
//  starWarsObjectiveC
//
//  Created by Mac on 9/27/17.
//  Copyright © 2017 David Gedeon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray *characterName;
NSMutableArray *pictureArray;
NSString *web;
NSMutableString *website;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Hello World");
    NSString *web = @"https://swapi.co/api/people/";
    NSMutableArray *characterName = [[NSMutableArray alloc]init];
    characterName = [self callSWApi:web and:characterName];
   
    [self.tableView reloadData];
     NSLog(@"%@", characterName);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)callSWApi: (NSString *)address and: (NSMutableArray *)names {
    NSURL *url = [NSURL URLWithString:address];
    //NSURLSession *session = NSURLSession.sharedSession;
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString *newUrl = [json objectForKey:@"next"];
    NSArray *result = [json objectForKey:@"results"];
    NSMutableArray *name = [NSMutableArray array];
    for(int i =0; i < [result count]; i++){
        NSDictionary *info = [result objectAtIndex:i];
        name[i] = [info objectForKey:@"name"];//WHAT THE FUCK!!!!!!
    }
    //[names addObject:name];
    [names addObjectsFromArray:name];
    if (newUrl != [NSNull null]){
        [self callSWApi:newUrl and:names];
    }
    else if (newUrl == [NSNull null]){
        //NSLog(@"%@", names);
        return names;
    }
    
    
    //NSURLSessionDataTask *task = [session dataTaskWithURL:url
    
    /*completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     if (error == nil) {return}
     else{*/
    return names;
}


//UITableViewController Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return characterName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    //cell.imageView.image = [UIImage imageNamed: pictureArray[indexPath.row]];
    NSLog(@"%@",[characterName objectAtIndex:indexPath.row]);
    [cell.textLabel setText: (NSString *)[characterName objectAtIndex:indexPath.row]];
    //cell.textLabel.text = cellId;
    
    return cell;
}


@end
