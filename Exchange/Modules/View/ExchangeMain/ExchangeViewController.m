#import "ExchangeViewController.h"
#import "ExchangeOptionsView.h"
#import "WalletStorage.h"
#import "CurrencyRateStorage.h"
#import "Money.h"
#import "Wallet.h"
#import "CurrencyRate.h"
#import "ExchangeMainViewModel.h"
#import "ExchangeOptionsViewModel.h"

@interface ExchangeViewController ()

@property (nonatomic, strong) DataSource<Wallet *> *walletDataSource;
@property (nonatomic, strong) DataSource<CurrencyRate *> *currencyRatesDataSource;
@property (nonatomic, strong) ExchangeMainViewModel *vm;

@end

@implementation ExchangeViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureDataSources];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refresh];
}

- (void)configureViewModel {
    if (self.vm != nil) return;
    self.vm = ExchangeMainViewModel.new;
}

- (void)configureDataSources {
    self.walletDataSource = [DataSource.alloc initWithStorage:WalletTestStorage.new];
    self.currencyRatesDataSource = [DataSource.alloc initWithStorage:CurrencyRateStorage.new];
    
    __weak let welf = self;
        self.walletDataSource.onNewData = ^(NSArray<Wallet *> *wallets) {
            let self = welf;
            let currentWallet = wallets[0];
            
            [self.vm refreshWithWallet:currentWallet];
        };
    
    
    self.currencyRatesDataSource.onNewData = ^(NSArray<CurrencyRate *> *rates) {
        let self = welf;
        [self.vm refreshWithCurrencyRates:rates];
    };
}

- (void)refresh {
    
    [self.walletDataSource fetch];
    [self.currencyRatesDataSource fetch];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    let vc = (ExchangeOptionsView *)segue.destinationViewController;
    [self configureViewModel];
    if (vc == nil) return;
    if ([vc.restorationIdentifier isEqualToString:@"ExchangeOptionsViewTop"]) {
        let __unused _ = vc.view;
        self.vm.top = vc.vm;
    }
    if ([vc.restorationIdentifier isEqualToString:@"ExchangeOptionsViewBottom"]) {
        let __unused _ = vc.view;
        self.vm.bottom = vc.vm;
    }
}

@end
