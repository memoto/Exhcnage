#import <Foundation/Foundation.h>
#import "CurrencyRateStorage.h"
#import "CurrencyRate.h"
#import "CurrencyRateXMLSerializer.h"
#import <AFNetworking/AFNetworking.h>

static NSString * const BaseUrl = @"http://www.ecb.europa.eu";
static NSString * const Uri = @"stats/eurofxref/eurofxref-daily.xml";

@interface CurrencyRateStorage ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CurrencyRateStorage {
    NSArray<CurrencyRate *> *_items;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = @[];
        
        let baseUrl = [NSURL URLWithString:[BaseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        let manager = [AFHTTPSessionManager.alloc initWithBaseURL:baseUrl];

        self.manager = manager;
    }
    return self;
}

- (AnyPromise *)items {
    
    if (_items.count > 0) {
        return [AnyPromise promiseWithValue:_items];
    }
    
    __weak let manager = self.manager;
    __weak let welf = self;
    
    let promise = [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        
        manager.responseSerializer = CurrencyRateXMLSerializer.serializer;
        
        [manager GET:Uri
          parameters:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            resolve(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            resolve(error);
        }];
    }].then(^(NSArray<CurrencyRate *> *result) {
        
        welf.items = result;
        return result;
    });
    
    return promise;
}

- (void)setItems:(NSArray *)items {
    // not implemented
}

@end

@implementation CurrencyRateTestStorage {
    NSArray<CurrencyRate *> *_items;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        let rates = @[
                      [CurrencyRate.alloc initWithCurrencyID:@"EUR" andRate:@1],
                      [CurrencyRate.alloc initWithCurrencyID:@"USD" andRate:@1.0623],
                      [CurrencyRate.alloc initWithCurrencyID:@"GBP" andRate:@0.85098]
                      ];
        _items = rates;
    }
    return self;
}

- (AnyPromise *)items {
    
   return [AnyPromise promiseWithValue:_items];
}

@end
