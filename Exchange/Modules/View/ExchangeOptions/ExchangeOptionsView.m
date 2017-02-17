#import "ExchangeOptionsView.h"
#import "ExchangeOptionsViewModel.h"
#import "ExchangeOptionsView+PagerDataSource.h"
#import "ExchangeCell.h"
#import "ExchangeCellViewModel.h"
#import "ExchangeCell+Updater.h"
#import "Money.h"

@interface ExchangeOptionsView ()

@property (readwrite, nonatomic, strong) NSArray<ExchangeCell *> *cells;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic) NSInteger currentCellIndex;

@end

@implementation ExchangeOptionsView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViewModel];
    [self setupChilds];
    [self setupLayout];
    [self setupCells];
    [self setupStyle];
}

- (void)setupChilds {
    let pageVC = [UIPageViewController.alloc
                  initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                  options:nil];
    
    pageVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    [pageVC didMoveToParentViewController:self];
    
    self.pageVC = pageVC;
}

- (void)setupStyle {
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.backgroundColor = self.cells.firstObject.view.backgroundColor;
}

- (void)setupLayout {
    let pageVC = self.pageVC;
    
    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:pageVC.view
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:self.view
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:pageVC.view
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:self.view
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:pageVC.view
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.view
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:pageVC.view
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    [self.view addConstraint:width];
    [self.view addConstraint:height];
    [self.view addConstraint:top];
    [self.view addConstraint:leading];

}

- (void)setupCells {

    let cells = NSMutableArray.new;
    
    for (ExchangeCellViewModel *vm in self.vm.options) {
        let cell = ExchangeCell.cell;
        [cells addObject:cell];
        
        cell.vm = vm;
    }
    
    self.cells = cells;
    self.currentCellIndex = 0;
}

- (void)setCells:(NSArray<ExchangeCell *> *)cells {
    _cells = cells;
    
    [self.pageVC setViewControllers:@[cells[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)setPageVC:(UIPageViewController *)pageVC {
    _pageVC = pageVC;
    
    pageVC.dataSource = self;
    pageVC.delegate = self;
}

- (void)configureViewModel {
    __weak let welf = self;
    
    self.vm = ExchangeOptionsViewModel.new;
    self.vm.didOptionChange = ^(ExchangeCellViewModel *vm) {
        let self = welf;
        [self updateWithOptionViewModel:vm];
    };
    
    [self.vm setDefaultExchangableCurrencies];
}

- (void)updateWithOptionViewModel:(ExchangeCellViewModel *)vm {
    for (ExchangeCell *cell in self.cells) {
        if (vm == cell.vm) return;
        
        [cell updateWithViewModel:cell.vm];
    }
}

@end
