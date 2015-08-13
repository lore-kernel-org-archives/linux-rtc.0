Return-Path: <rtc-linux+bncBDKZNNNLXAHBB77IWGXAKGQEDAVVFSQ@googlegroups.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com. [2607:f8b0:400e:c03::233])
        by gmr-mx.google.com with ESMTPS id qa1si195510pdb.1.2015.08.13.03.42.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 03:42:07 -0700 (PDT)
Received: by mail-pa0-x233.google.com with SMTP id yb7so35255108pab.0
        for <rtc-linux@googlegroups.com>; Thu, 13 Aug 2015 03:42:07 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
Message-ID: <55CC7479.6080902@samsung.com>
Date: Thu, 13 Aug 2015 19:42:01 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-Version: 1.0
To: rtc-linux@googlegroups.com
CC: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, sbkim73@samsung.com,
 jy0922.shim@samsung.com
Subject: Re: [rtc-linux] [PATCH] rtc: s5m: fix to update ctrl register
References: <1439455764-23526-1-git-send-email-jy0922.shim@samsung.com> <55CC6B28.5010707@samsung.com>
In-Reply-To: <55CC6B28.5010707@samsung.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

W dniu 13.08.2015 o 19:02, Krzysztof Kozlowski pisze:
> W dniu 13.08.2015 o 17:49, Joonyoung Shim pisze:
>> According to datasheet, the S2MPS13X and S2MPS14X should update write
>> buffer via setting WUDR bit to high after ctrl register is updated.
> 
> Hi,
> 
> I cannot find this information in S2MPS14 datasheet. On which page is it?
> 
> 
>>
>> If not, ALARM interrupt of rtc-s5m doesn't happen first time when i use
>> tools/testing/selftests/timers/rtctest.c test program and hour format is
>> used to 12 hour mode in Odroid-XU3 board.
> 
> Two questions here:
> 1. Earlier you mentioned S2MPS1[34], now Odroid XU3 which has S2MPS11.
> Are you sure that this applies to all of them (S2MPS11, S2MPS13 and
> S2MP14)? There are some minor differences between them so I would not be
> surprised if only some of them required this action.
> 
> 2. The driver operates in 24-hour omode. Actually it sets the 24-hour
> mode just before your new regmap_update_bits() call. What do you mean by
> 12-hour mode?
> 
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Cc: <stable@vger.kernel.org>
> 
> Thanks for putting a cc-stable tag. How far this should be ported? If
> this is needed only for S2MPS11 then v4.1. If all of them then probably
> for earlier version?
> 
> Best regards,
> Krzysztof

One more doubt. On my Odroid XU3 first and consecutive executions
(including first) of rtctest run fine. They pass. Can you describe
exactly observable issue and how to reproduce it? This is also important
as a reason for stable backport.

I tested it on next-20150729 on board with Hardkernel bootloader. Maybe
the bootloader sets 12-hour mode which cannot be switched to 24-hour?

Best regards,
Krzysztof



-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
