//
//  MainTableViewController.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/26.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "MainTableViewController.h"
#import "CyclePagingScrollViewController.h"
#import "Story.h"
#import "GCDQueue.h"
#import "MainPageDataSource.h"
#import "DailyStoryTableViewCell.h"
#import "DailyStoryHeaderViewCell.h"
#import "NavgationBarView.h"
#import "LaunchScreenViewController.h"
#import "DetailViewController.h"

static const CGFloat headerViewHeight = 223.0f;

@interface MainTableViewController ()

@property (nonatomic, readonly) CyclePagingScrollViewController* cyclePagingScrollViewController;
@property (nonatomic, readonly) MainPageDataSource* dataSource;
@property (nonatomic, readonly) UIView* statusBar;
@property (nonatomic, readonly) NavgationBarView* navigationBar;
@property (nonatomic, readonly) CGFloat navigationBarAlpha;
@property (nonatomic) BOOL retrievingData;

@end

@implementation MainTableViewController

@synthesize cyclePagingScrollViewController = _cyclePagingScrollViewController;
@synthesize dataSource = _dataSource;
@synthesize statusBar = _statusBar;
@synthesize navigationBar = _navigationBar;

+(NSString*)reusableTableViewCellIdentifier {
    static NSString* identifier = nil;
    @synchronized(self) {
        if (identifier == nil) {
            identifier = @"DailyStoryTableViewCell";
        }
    }
    return identifier;
}

+(NSString*)reusableHeaderCellIdentifier {
    static NSString* identifier = nil;
    @synchronized(self) {
        if (identifier == nil) {
            identifier = @"DailyStoryHeaderViewCell";
        }
    }
    return identifier;
}

+(UIColor*)themeColorTransparent {
    static UIColor* color = nil;
    @synchronized(self) {
        if (color == nil) {
            color = [[UIColor alloc]initWithRed:0.2 green:0.6 blue:0.9 alpha:0.0];
        }
    }
    return color;
}

+(UIColor*)themeColor {
    static UIColor* color = nil;
    @synchronized(self) {
        if (color == nil) {
            color = [[UIColor alloc]initWithRed:0.2 green:0.6 blue:0.9 alpha:1.0];
        }
    }
    return color;
}

-(MainPageDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[MainPageDataSource alloc]init];
    }
    return _dataSource;
}

-(void)retrieveDataFromServer: (void (^)(void)) completion {
    [self.dataSource retrieveDataFromServer:completion];
}

-(CGRect)frameForCyclePagingScrollView {
    return CGRectMake(0, 0, self.view.bounds.size.width, headerViewHeight);
}

-(CyclePagingScrollViewController *)cyclePagingScrollViewController {
    if (_cyclePagingScrollViewController == nil) {
        _cyclePagingScrollViewController = [[CyclePagingScrollViewController alloc]init];
        _cyclePagingScrollViewController.view.frame = [self frameForCyclePagingScrollView];
        _cyclePagingScrollViewController.storiesDataSource = self;
    }
    return _cyclePagingScrollViewController;
}

-(UIView *)statusBar {
    if (_statusBar == nil) {
        _statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
        _statusBar.backgroundColor = [MainTableViewController themeColorTransparent];
    }
    return _statusBar;
}

-(NavgationBarView *)navigationBar {
    if (_navigationBar == nil) {
        _navigationBar = [[NavgationBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40.0f)];
        _navigationBar.backgroundColor = [MainTableViewController themeColorTransparent];
        _navigationBar.title = @"热门新闻";
    }
    return _navigationBar;
}

-(CGFloat)navigationBarAlpha {
    CGFloat contentOffsetY = self.tableView.contentOffset.y;
    contentOffsetY = MAX(contentOffsetY, 0);
    return contentOffsetY / (headerViewHeight - 64.0f);
}

-(void)adjustNavigationBarVisibility {
    if (self.tableView.contentOffset.y > headerViewHeight) {
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.navigationBar.hidden = YES;
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.navigationBar.hidden = NO;
    }
}

-(void)adjustNavigationBarBackgroundColorAlphaComponent {
    UIColor* backgroundColor = [self.statusBar.backgroundColor colorWithAlphaComponent:self.navigationBarAlpha];
    self.navigationBar.backgroundColor = backgroundColor;
    self.statusBar.backgroundColor = backgroundColor;
}

-(void)supplementStoriesDataFromServerIfNecessary {
    if (self.retrievingData == NO) {
        CGFloat currentOffset = self.tableView.contentOffset.y;
        CGFloat maximumOffset = self.tableView.contentSize.height - self.tableView.frame.size.height;
        if (maximumOffset <= currentOffset + 10) {
            self.retrievingData = YES;
            [self.dataSource getLastStoriesDataFromServer:^{
                [UIView setAnimationsEnabled:NO];
                [self.tableView beginUpdates];
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:[self.dataSource numberOfSections] - 1]
                              withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
                [UIView setAnimationsEnabled:YES];
                self.retrievingData = NO;
            }];
        }
    }
}

-(void)viewDidLoad {
    [self setupTableView];
    [self setupNavigationBar];
    [self setNeedsStatusBarAppearanceUpdate];
    self.retrievingData = NO;
}

-(void)setupTableView {
    self.view.backgroundColor = [MainTableViewController themeColor];
    [self addChildViewController:self.cyclePagingScrollViewController];
    self.tableView.tableHeaderView = self.cyclePagingScrollViewController.view;
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
}

-(void)setupNavigationBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar addSubview:self.statusBar];
    [self.navigationController.navigationBar addSubview:self.navigationBar];
}

-(NSInteger)numberOfItemsInCyclePagingScrollView:(CyclePagingScrollView *)cyclePagingScrollView {
    return [self.dataSource numberOfTopStories];
}

-(Story *)cyclePagingScrollView:(CyclePagingScrollView *)cyclePagingScrollView storyForItemAtIndex:(NSInteger)index {
    return [self.dataSource topStoryAtIndex:index];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfStoriesInSection:section];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self supplementStoriesDataFromServerIfNecessary];
    [self adjustNavigationBarVisibility];
    [self adjustNavigationBarBackgroundColorAlphaComponent];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyStoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[MainTableViewController reusableTableViewCellIdentifier]];
    if (cell == nil) {
        cell = [[DailyStoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MainTableViewController reusableTableViewCellIdentifier]];
    }    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyStoryTableViewCell* dailyStoryCell = (DailyStoryTableViewCell*)cell;
    dailyStoryCell.story = [self.dataSource dailyStoryAtIndex:indexPath.row inSection:indexPath.section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DailyStoryHeaderViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[MainTableViewController reusableHeaderCellIdentifier]];
    if (cell == nil) {
        cell = [[DailyStoryHeaderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MainTableViewController reusableHeaderCellIdentifier]];
        cell.contentView.backgroundColor = [MainTableViewController themeColor];
        CGRect frame = cell.frame;
        frame.size.width = self.view.bounds.size.width;
        cell.frame = frame;
    }
    cell.date = [self.dataSource dateOfStoriesInSection:section];
    
    // 防止 header cell 莫名其妙的消失.
    return cell.contentView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController* detailViewController = [[DetailViewController alloc]init];
    Story* selectedDailyStory = [self.dataSource dailyStoryAtIndex:indexPath.row inSection:indexPath.section];
    detailViewController.identifier = selectedDailyStory.identifier;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
