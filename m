Return-Path: <rtc-linux+bncBCPM5SUWUYIRBRUDX24AKGQEUR22HMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-vk0-x22b.google.com (mail-vk0-x22b.google.com. [2607:f8b0:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id g191si1546063vkg.0.2016.04.14.04.40.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2016 04:40:54 -0700 (PDT)
Received: by mail-vk0-x22b.google.com with SMTP id e185so105458139vkb.1
        for <rtc-linux@googlegroups.com>; Thu, 14 Apr 2016 04:40:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABrG=Zw1g7a6YQnMEt6tJ5SeERM8OYcQ1=qvCegJy1G+n=WOcQ@mail.gmail.com>
References: <CABrG=Zw1g7a6YQnMEt6tJ5SeERM8OYcQ1=qvCegJy1G+n=WOcQ@mail.gmail.com>
Date: Thu, 14 Apr 2016 20:40:54 +0900
Message-ID: <CAC5umygV1U-g=WOoTaZuSmjPNJ5gC5b+zk47MAxVJxz3vF=6pA@mail.gmail.com>
Subject: [rtc-linux] Re: RTC DS3231 returns wrong temperature value.
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Michael Tatarinov <kukabu@gmail.com>, Zhuang Yuyao <mlistz@gmail.com>
Cc: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Michael,

Thanks for testing.

2016-04-14 16:23 GMT+09:00 Michael Tatarinov <kukabu@gmail.com>:
> Hello
>
> I tried get temperature from RTC DS3231 (patch
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-ds1307.c?id=445c02076f1e60d2ee51503bf1288ef9f3bc8809)
> but returned value wrong. Looks like the patch have a bug in type
> conversion.
> Sometime ago I wrote small program to gets temperature and it works
> fine. I attaches the source code a modified version with a
> demonstration of a bug.
>
> $ cat /sys/devices/platform/soc/20804000.i2c/i2c-1/1-0068/hwmon/hwmon1/temp1_input
> -29036
> $ ./ds3231 -d /dev/i2c-1 -a 0x68 -m t -f
> int     36500
> int->int16_t    -29036

Zhuang Yuyao has created a patch for a bug in retrieving temperature.
(ds3231_hwmon_read_temp() takes s16 *, but it is too small for a
multiplication with 250.)  Zhuang's patch should fixes the same problem you got.

Zhuang, do you plan to submit the patch to rtc-linux@googlegroups.com ?
Or should I send it on behalf of you?

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
