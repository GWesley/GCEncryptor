# GCEncryptor
A Mac app for AES file encryption, using RNCryptor lib

##How to use

```
#import "RNDecryptor.h"

NSData *data = [NSData dataWithContentsOfFile:@""];
NSError *error = nil;
NSData *decryptData = [RNDecryptor decryptData:data withPassword:PWD error:&error];
NSAssert(!error, @"Decrypt data fail");
```
