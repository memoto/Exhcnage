#import "ExchangeViewController.h"
#import "WalletStorage.h"
#import "CurrencyRateStorage.h"
#import "Money.h"
#import "Wallet.h"
#import "CurrencyRate.h"

@interface ExchangeViewController ()

@property (nonatomic, strong) DataSource<Wallet *> *walletDataSource;
@property (nonatomic, strong) DataSource<CurrencyRate *> *currencyRatesDataSource;

@property (nonatomic, strong) UIPageViewController *topPageVC;
@property (nonatomic, strong) UIPageViewController *bottomPageVC;

@end

@interface ExchangeViewController (PagerDataSource) <UIPageViewControllerDataSource>

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViewModel];
    [self configureDataSources];
    
    let pageVC = UIPageViewController.new;
    pageVC.dataSource = self;
    self.topPageVC = pageVC;
    
    
    //self.bottomPageVC
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refresh];
}

- (void)configureViewModel {
}

- (void)configureDataSources {
    self.walletDataSource = [DataSource.alloc initWithStorage:WalletTestStorage.new];
    self.currencyRatesDataSource = [DataSource.alloc initWithStorage:CurrencyRateStorage.new];
    
    __weak let welf = self;
        self.walletDataSource.onNewData = ^(NSArray<Wallet *> *wallets) {
            let self = welf;
            let currentWallet = wallets[0];
            //[self.vm refreshWithMoney:currentWallet];
        };
    
    
    self.currencyRatesDataSource.onNewData = ^(NSArray<CurrencyRate *> *rates) {
        //[welf.vm refreshWithCurrencyRates:rates];
    };
}

- (void)refresh {
    
    //[self.walletDataSource fetch];
    [self.currencyRatesDataSource fetch];
}

@end

@implementation ExchangeViewController (PagerDataSource)

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    return nil;
}

@end
