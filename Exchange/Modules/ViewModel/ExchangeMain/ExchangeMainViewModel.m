#import "ExchangeMainViewModel.h"
#import "ExchangeOptionsViewModel.h"
#import "ExchangeCellViewModel.h"

#import "Money.h"

@implementation ExchangeMainViewModel

- (void)setTop:(ExchangeOptionsViewModel *)top {
    _top = top;
    
    __weak let welf = self;
    top.didSelectOption = ^(ExchangeCellViewModel *option) {
        let bottom = welf.bottom;
        if (bottom == nil) return;
        
        let relativeCurrency = option.money.currencyID;
        [bottom refreshWithRelativeCurrency:relativeCurrency];
    };
    top.didOptionBidChange =  ^(ExchangeCellViewModel *option) {
        let bottom = welf.bottom;
        if (bottom == nil) return;
        
        let amount = [NSNumber numberWithDouble:option.bid];
        let moneyToConvert = [Money.alloc initWithCurrencyID:option.money.currencyID andAmount:amount];
        [bottom convertMoney:moneyToConvert];
    };
    
}

- (void)setBottom:(ExchangeOptionsViewModel *)bottom {
    _bottom = bottom;
    
    __weak let welf = self;
    bottom.didOptionChange = ^(ExchangeCellViewModel *option) {
        let top = welf.top;
        if (top == nil) return;
        
        let relativeCurrency = option.money.currencyID;
        [top refreshWithRelativeCurrency:relativeCurrency];
    };
    
    bottom.didOptionBidChange = ^(ExchangeCellViewModel *option) {
        let top = welf.top;
        if (top == nil) return;
        
        let moneyToConvert = option.money;
        [top convertMoney:moneyToConvert];
    };
}

- (void)refreshWithWallet:(Wallet *)wallet {
    
    [self.top refreshWithWallet:wallet];
    [self.bottom refreshWithWallet:wallet];
}

@end
