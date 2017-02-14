#import "CurrencyRateXMLSerializer.h"
#import "CurrencyRate.h"

@interface CurrencyRateXMLSerializer ()

@property (nonatomic, strong) NSMutableArray<CurrencyRate *> *result;

@end

@interface CurrencyRateXMLSerializer (Parser) <NSXMLParserDelegate>
@end

@implementation CurrencyRateXMLSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError * __autoreleasing _Nullable *)error {
    
    self.result = NSMutableArray.new;
    id rawResponse = [super responseObjectForResponse:response
                                                 data:data
                                                error:error];
    
    NSXMLParser *parser = rawResponse;
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities: YES];
    [parser parse];
    
    // self.result is populated by the xml parser delegate
    return self.result;
}

@end

@implementation CurrencyRateXMLSerializer (Parser)

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if (![elementName isEqualToString:@"Cube"]) return;
    if (attributeDict[@"currency"] == nil) return;
    
    let currency = attributeDict[@"currency"];
    let rate = [NSNumber numberWithDouble:attributeDict[@"rate"].doubleValue];
    let item = [CurrencyRate.alloc initWithCurrencyID:currency andRate:rate];
    
    [self.result addObject:item];
}

@end
