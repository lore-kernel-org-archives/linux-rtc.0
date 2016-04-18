Return-Path: <rtc-linux+bncBDVNH3HM2UDBBT7L2K4AKGQEVTB3XSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com. [2607:f8b0:4003:c01::22a])
        by gmr-mx.google.com with ESMTPS id r5si258171igp.0.2016.04.18.03.24.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2016 03:24:15 -0700 (PDT)
Received: by mail-ob0-x22a.google.com with SMTP id j9so94187306obd.3
        for <rtc-linux@googlegroups.com>; Mon, 18 Apr 2016 03:24:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1460938902-3120-1-git-send-email-akinobu.mita@gmail.com>
References: <1460938902-3120-1-git-send-email-akinobu.mita@gmail.com>
Date: Mon, 18 Apr 2016 14:24:15 +0400
Message-ID: <CABrG=ZzVx3XcViRvuB6wqdJpaBF11wke2otHzbd8_M9S2T1rPQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: ds3231 temperature s16 overflow
From: Michael Tatarinov <kukabu@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Zhuang Yuyao <mlistz@gmail.com>,
	Zhuang Yuyao <zhuangyy@syan.com.cn>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Thanks.

I'm testing the patch, it workins as expected.

$ cat /sys/devices/platform/soc/20804000.i2c/i2c-1/1-0068/hwmon/hwmon1/temp1_input
33000

2016-04-18 4:21 GMT+04:00, Akinobu Mita <akinobu.mita@gmail.com>:
> From: Zhuang Yuyao <mlistz@gmail.com>
>
> while retrieving temperature from ds3231, the result may be overflow
> since s16 is too small for a multiplication with 250.
>
> ie. if temp_buf[0] == 0x2d, the result (s16 temp) will be negative.

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
