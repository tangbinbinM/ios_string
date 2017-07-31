//
//  main.m
//  string_ios
//
//  Created by yg on 2017/7/31.
//  Copyright © 2017年 TBB. All rights reserved.
//

#import <Foundation/Foundation.h>

//测试字符串对象
void test1()
{
    //改变引用变量的值,没有改变对象的内容
    NSString *str = @"Hello";
    str = @"World";
    NSLog(@"str=%@", str);
    //字符串池的存在,str1,str为两个不同的引用指向了同一块资源。
    NSString *str1 = @"ABCDEF";
    NSString *str2 = @"ABCDEF";
    NSLog(@"str1=%p,str2=%p", str1, str2);
    if(str1 == str2){
        NSLog(@"str1==str2");
    }
    str2 = @"DEF";
}

//创建和初始化字符串对象
void test2()
{
    NSString *str1 = @"Hello";
    NSString *str2 = [[NSString alloc]initWithString:str1];//@"World";
    //将C风格的字符串转换成OC风格的字符串对象
    char str[] = "Hai,Hello";
    NSString *str3 = [[NSString alloc]initWithCString:str encoding:NSUTF8StringEncoding];
    //将OC风格的字符串对象转换成C风格的字符串
    const char *cstr = [str3 cStringUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"cstr=%s", cstr);
    NSString *str4 = [[NSString alloc]initWithFormat:@"%02d:%02d:%02d", 8, 5, 9];
    NSLog(@"%@", str4);
    NSString *str5 = [NSString stringWithFormat:@"%02d:%02d:%02d", 8, 5, 9];
    NSLog(@"%@", str5);
    
    //从文件中读取内容到字符串对象
    NSString *str6 = [NSString stringWithContentsOfFile:@"/Users/Daniel/Desktop/a.txt" encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"str6:%@", str6);
    //将字符串中的内容写到一个文件中
    [str6 writeToFile:@"/Users/Daniel/Desktop/b.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

//字符串的普通方法
void test3()
{
    const char *str1 = "我们";//E68891
    //NSLog(@"%X%X%X", *str1, *(str1+1), *(str1+2));
    NSLog(@"strlen(str1)=%ld", strlen(str1));
    //在Unicode编码中,一个汉字是一个字符,有几个汉字,长度就是几
    NSString *str2 = @"我们都是,好孩子";
    NSLog(@"length:%ld", str2.length);
    NSLog(@"lengthOfBytes:%ld", [str2 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    
    NSString *str3 = @"Hello World!";
    NSLog(@"length:%ld", str3.length);
    
    //获取指定位置的字符
    NSString *str4 = @"ABCDEFG";
    char ch = [str4 characterAtIndex:0];
    NSLog(@"%c", ch);
    
    //合并,拼接字符串
    NSString *str5 = @"ABC";
    NSString *str6 = @"DEF";
    NSString *str7 = [str5 stringByAppendingString:str6];
    NSLog(@"str7:%@", str7);
    str5 = [str5 stringByAppendingFormat:@"%02d:%02d:%02d",2,3,4];
    NSLog(@"str5=%@", str5);
    
}

//字符串分解方法
void test4()
{
    NSString *info = @"Daniel:30:1:123456.78";
    NSArray *array = [info componentsSeparatedByString:@":"];
    NSLog(@"array[0]=%@", array[0]);
    NSLog(@"array[1]=%@", array[1]);
    NSLog(@"array[2]=%@", array[2]);
    NSString *str = @"ABCDEFGHIJKLMN";
    //包括起始位置，下标为8开始到结束
    NSString *str2 = [str substringFromIndex:8];
    NSLog(@"str2=%@", str2);
    //不包括结束位置，从零到结束的八个字符。
    NSString *str3 = [str substringToIndex:8];
    NSLog(@"str3=%@", str3);
    NSRange r = NSMakeRange(2, 4);
    //从下标为2的字符开始的四个字符
    NSString *str4 = [str substringWithRange:r];
    NSLog(@"str4=%@", str4);
}

//查找子串
void test5()
{
    //默认是大小写敏感
    NSString *str = @"Hello World.";
    NSRange r = [str rangeOfString:@"LLO"];
    if (r.location == NSNotFound) {
        NSLog(@"没有找着指定的子串");
    }else{
        NSLog(@"找着了,在%ld位置", r.location);
    }
    //忽略大小写查找子串
    r = [str rangeOfString:@"LLO" options:NSCaseInsensitiveSearch];
    if (r.length == 0){
        NSLog(@"没找到指定的字符子串");
    }else{
        NSLog(@"找着了,在%ld位置", r.location);
    }
}

//替换子串
void test6()
{
    NSString *str = @"TRHelloWorld.mm";
    str = [str stringByReplacingOccurrencesOfString:@".mm" withString:@".java"];
    NSLog(@"str:%@", str);
    str = [str stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"HELLO"];
    NSLog(@"str:%@", str);
}

//比较大小
void test7()
{
    NSString *str1 = @"aab";
    NSString *str2 = @"abc";
    NSComparisonResult result = [str1 compare:str2];
    if (result == NSOrderedAscending) {
        NSLog(@"str1 < str2");
    }else if(result == NSOrderedDescending){
        NSLog(@"str1 > str2");
    }else {
        NSLog(@"str1 == str2");
    }
    
    str1 = @"abc";
    str2 = @"ABC";
    if([str1 compare:str2 options:NSCaseInsensitiveSearch] == NSOrderedSame){
        NSLog(@"忽略大小写,两个字符串内容相同");
    }
    
    str1 = @"A10.txt";
    str2 = @"A8.txt";
    result = [str1 compare:str2 options:NSNumericSearch];//A10.txt > A8.txt
    NSLog(@"result:%ld", result);
}

//判等
void test8()
{
    NSString *str1 = @"ABC";
    NSString *str2 = @"ABC";
    if(str1 == str2){
        NSLog(@"str1和str2==");
    }
    NSString *str3 = [[NSString alloc]initWithFormat:@"%@", @"ABC"];
    if(str1 == str3){
        NSLog(@"str1和str3也==");
    }
    //NSString类中的isEqual:方法比较的是内容,但是,在实际开发中,对于字符串类,基本不会使用此方法去比较内容是否相等,一般用isEqualToString:
    if([str1 isEqual:str3]){
        NSLog(@"str1和str3内容相等");
    }
    //专门给字符串类定制的比较方法
    if([str1 isEqualToString:str3]){
        NSLog(@"str1和str3的内容肯定是相同的");
    }
    
    //判断是否是指定字符串开始或结束
    NSString *filename = @"HelloWorld.mm";
    if([filename hasPrefix:@"Hello"]){
        NSLog(@"文件名以Hello开始");
    }
    if([filename hasSuffix:@".mm"]) {
        NSLog(@"这个文件是Objective C++源文件");
    }
}

//改变大小写
void test9()
{
    NSString *str = @"Hello World.";
    str = [str lowercaseString];
    NSLog(@"str:%@", str);
    str = [str capitalizedString];
    NSLog(@"str:%@", str);
}

//将字符串转换成其他基本类型
void test10()
{
    NSString *str1 = @"123";
    int i1 = [str1 intValue];
    NSLog(@"i1=%d", i1);
    NSInteger i2 = [str1 integerValue];
    NSLog(@"i2=%ld", i2);
    NSString *str2 = @"3.1415926";
    float f = [str2 floatValue];
    NSLog(@"f=%f", f);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test10();
    }
    return 0;
}
