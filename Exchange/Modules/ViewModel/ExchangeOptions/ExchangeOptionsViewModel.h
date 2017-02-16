#import <Foundation/Foundation.h>

@class ExchangeCellViewModel;
@class Money;

@interface ExchangeOptionsViewModel : NSObject

// MARK: - Notifier
@property (nonatomic, copy) void(^didChange)(ExchangeOptionsViewModel *);
@property (nonatomic, copy) void(^didOptionChange)(ExchangeCellViewModel *);

@property (nonatomic, strong) NSArray<ExchangeCellViewModel *> *options;

- (void)setDefaultExchangableCurrencies;
//- (void)refreshWithMoney:(Money *)money;

@end
