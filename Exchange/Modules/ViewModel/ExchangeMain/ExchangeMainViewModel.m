#import "ExchangeMainViewModel.h"
#import "ExchangeOptionsViewModel.h"
#import "ExchangeCellViewModel.h"

#import "Money.h"

@interface ExchangeMainViewModel ()

@property (nonatomic, copy) Wallet *wallet;

@end

@implementation ExchangeMainViewModel

- (void)setTop:(ExchangeOptionsViewModel *)top {
    _top = top;
    
    __weak let welf = self;
    top.didSelectOption = ^(ExchangeCellViewModel *option) {
        let self = welf;
        let bottom = welf.bottom;
        if (bottom == nil) return;
        
        [self checkValidation];
        
        self.canExchange = !option.isOutOfBudget;
        self.didValidation(self.canExchange);
        
        let relativeCurrency = option.money.currencyID;
        [bottom refreshWithRelativeCurrency:relativeCurrency];
    };
    top.didOptionBidChange =  ^(ExchangeCellViewModel *option) {
        let self = welf;
        let bottom = welf.bottom;
        if (bottom == nil) return;
        
        [self checkValidation];
        
        let amount = [NSNumber numberWithDouble:-option.bid];
        let moneyToConvert = [Money.alloc initWithCurrencyID:option.money.currencyID andAmount:amount];
        [bottom convertMoney:moneyToConvert];
    };
    
    top.didSelectOption(top.options[0]);
}

- (void)setBottom:(ExchangeOptionsViewModel *)bottom {
    _bottom = bottom;
    
    __weak let welf = self;
    bottom.didSelectOption = ^(ExchangeCellViewModel *option) {
        let self = welf;
        let top = welf.top;
        if (top == nil) return;
        
        [self checkValidation];
        
        let relativeCurrency = option.money.currencyID;
        [top refreshWithRelativeCurrency:relativeCurrency];
    };
    
    bottom.didOptionBidChange = ^(ExchangeCellViewModel *option) {
        let self = welf;
        let top = welf.top;
        if (top == nil) return;
        
        [self checkValidation];
        
        let amount = [NSNumber numberWithDouble:-option.bid];
        let moneyToConvert = [Money.alloc initWithCurrencyID:option.money.currencyID andAmount:amount];
        [top convertMoney:moneyToConvert];
    };
    
    bottom.didSelectOption(bottom.options[0]);
}

- (void)checkValidation {
    let topOption = self.top.selectedOption;
    let bottomOption = self.bottom.selectedOption;
    
    if (topOption && bottomOption) {
        self.canExchange = !topOption.isOutOfBudget && !bottomOption.isOutOfBudget;
        self.didValidation(self.canExchange);
    }
}

- (void)refreshWithWallet:(Wallet *)wallet {
    self.wallet = wallet;
    
    [self.top refreshWithWallet:wallet];
    [self.bottom refreshWithWallet:wallet];
}

- (void)refreshWithCurrencyRates:(NSArray<CurrencyRate *> *)currencyRates {
    
    [self.top refreshWithCurrencyRates:currencyRates];
    [self.bottom refreshWithCurrencyRates:currencyRates];
}

- (void)doExchange {
    
    let walletAfterTop = [self.top walletAfterExchange];
    [self.bottom refreshWithWallet:walletAfterTop];
    let walletAfterBottom = [self.bottom walletAfterExchange];
    let changedWallet = walletAfterBottom;
    
    if (self.didWalletChange) {
        self.didWalletChange(changedWallet);
        
        [self checkValidation];
    }
}

@end
