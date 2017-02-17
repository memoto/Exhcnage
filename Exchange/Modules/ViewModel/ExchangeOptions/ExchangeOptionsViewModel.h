#import <Foundation/Foundation.h>

@class ExchangeCellViewModel;
@class Money;
@class Wallet;
@class CurrencyRate;

@interface ExchangeOptionsViewModel : NSObject

// MARK: - Notifier
@property (nonatomic, copy) void(^didChange)(ExchangeOptionsViewModel *);
@property (nonatomic, copy) void(^didOptionChange)(ExchangeCellViewModel *);
@property (nonatomic, copy) void(^didOptionBidChange)(ExchangeCellViewModel *);
@property (nonatomic, copy) void(^didSelectOption)(ExchangeCellViewModel *);

@property (nonatomic, strong) NSArray<ExchangeCellViewModel *> *options;
@property (nonatomic, weak) ExchangeCellViewModel *selectedOption;

- (void)setDefaultExchangableCurrencies;
- (void)selectOptionAtIndex:(NSInteger)index;
- (void)refreshWithRelativeCurrency:(NSString *)relCurrency;
- (void)convertMoney:(Money *)money;
- (void)refreshWithWallet:(Wallet *)wallet;
- (void)refreshWithCurrencyRates:(NSArray<CurrencyRate *>*)currencyRates;
- (Wallet *)walletAfterExchange;

@end
