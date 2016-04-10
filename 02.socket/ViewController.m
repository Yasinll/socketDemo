//
//  ViewController.m
//  02.socket
//
//  Created by 浅爱 on 16/3/2.
//  Copyright © 2016年 my. All rights reserved.
//

#import "ViewController.h"

// 导入三个头文件
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 1.创建socket
    /**
     *  参数 int domain, int type, int protocol
     *
     *  @param <#int#>  domain协议族 指定ipv4 或者ipv6等ip地址协议
     *  @param <#int#>  type 传输方式TCP(SOCK_STREAM) & UDP (SOCK_DGRAM)
     *  @param <#int#>  protocol tcp传输协议
     *
     *  @return 返回值 大于0 成功
     */
    int clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    
    if (clientSocket > 0) {
        
        NSLog(@"%d", clientSocket);
        
    } else {
    
        NSLog(@"fail");
        
    }
    
    // 2.连接
    /*
     struct sockaddr_in addr;
     addr.sin_family = AF_INET;
     addr.sin_port=htons(PORT);
     addr.sin_addr.s_addr = inet_addr(SERVER_IP);
     */
    struct sockaddr_in addr;
    
    // 指定ipv4
    addr.sin_family = AF_INET;
    
    // 端口号  高低位转换
    addr.sin_port = htons(12345);
    
    // ip地址 字符串转数字
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    /**
     *
     *  @param <#int#>       socket
     *  @param #>         结构体 指定ip和端口号
     *  @param <#socklen_t#> 结构体长度
     *
     *  @return 返回值 0成功 非0 失败
     */
    int connectResult = connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    
    // 通过系统内置的netcat坚挺端口来模拟本地服务器 终端命令:nc -lk 12345
    if (connectResult == 0) {
        
        NSLog(@"connect is OK");
        
    } else {
    
        NSLog(@"connect error");
    
    }
    
    // 3.发送
    char *str = "my";
    
    /**
     *
     *  @param <#int#>    socket
     *  @param #>      发送的数据
     *  @param <#size_t#> 要发送的数据大小
     *  @param <#int#>    发送方式 一般填0 即可
     *
     *  @return 返回值 发送成功的字符长度
     */
    ssize_t sendLen = send(clientSocket, str, strlen(str), 0);
 
    NSLog(@"%ld, %ld", sendLen, sizeof(str));
    
    // 接收
    char *buffer[1024];
    
    /**
     *
     *  @param <#int#>    socket
     *  @param #>      接收数据的缓存
     *  @param <#size_t#> 缓冲的长度
     *  @param <#int#>    指定调用方式。一般填0 即可
     *
     *  @return 返回值:成功接收字符的长度
     */
    ssize_t receiveLen = recv(clientSocket, buffer, sizeof(buffer), 0);
    
    NSLog(@"%ld", receiveLen);
    
    
    // 关闭，释放资源
    close(clientSocket);
    
    
}


@end






