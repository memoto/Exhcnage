#import "ExchangeOptionsViewModel.h"
#import "ExchangeCellViewModel.h"
#import "ExchangeCellViewModel+ActionReducer.h"
#import "Money.h"
#import "Wallet.h"

#define ExchangableCurrencies @[@"EUR", @"USD", @"GBP"]

@implementation ExchangeOptionsViewModel

- (void)setOptions:(NSArray<ExchangeCellViewModel *> *)options {
    _options = options;
    
    __weak let welf = self;
    
    for (ExchangeCellViewModel *option in options) {
        option.didChange = ^(ExchangeCellViewModel *option) {
            let self = welf;
            
            [self syncOtherOptionsWithOption:option];
            if (self.didOptionChange) {
                self.didOptionChange(option);
            }
            if (self.didChange) {
                self.didChange(self);
            }
        };
        option.didBidChange = ^(ExchangeCellViewModel *option) {
            let self = welf;
            
            if (self.didOptionBidChange) {
                self.didOptionBidChange(option);
            }
        };
    }
}

- (void)syncOtherOptionsWithOption:(ExchangeCellViewModel *)option {
    for (ExchangeCellViewModel *otherOption in self.options) {
        if (otherOption == option) continue;
        
        [otherOption convertMoney:option.bidMoney];
    }
}

- (void)setDefaultExchangableCurrencies {
    let options = NSMutableArray.new;
    let currencies = ExchangableCurrencies;
    
    for (NSString *currencyID in currencies) {
        let money = [Money.alloc initWithCurrencyID:currencyID andAmount:@0];
        let cellVM = [ExchangeCellViewModel.alloc initWithCurrency:nil andMoney:nil];
        [cellVM refreshWithMoney:money];
        
        [options addObject:cellVM];
    }
    
    self.options = options;
}

- (void)selectOptionAtIndex:(NSInteger)index {
    
    let option = self.options[index];
    
    if (self.didSelectOption) {
        self.didSelectOption(option);
    }
}

- (void)refreshWithRelativeCurrency:(NSString *)relCurrency {
    
    for (ExchangeCellViewModel *option in self.options) {
        [option refreshWithRelativeCurrency:relCurrency];
    }
}

- (void)refreshWithWallet:(Wallet *)wallet {
    
    for (ExchangeCellViewModel *option in self.options) {
        let requiredCurrency = option.money.currencyID;
        let money = [wallet moneyForCurrency:requiredCurrency];
        [option refreshWithMoney:money];
    }
}

- (void)convertMoney:(Money *)money {
    for (ExchangeCellViewModel *option in self.options) {
        [option convertMoney:money];
    }
}

@end
