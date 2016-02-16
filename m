Return-Path: <rtc-linux+bncBCPM5SUWUYIRBC7KRS3AKGQE2YY42AY@googlegroups.com>
Received: from mail-vk0-x22e.google.com (mail-vk0-x22e.google.com. [2607:f8b0:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id c66si1113028vkf.0.2016.02.16.06.41.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 06:41:15 -0800 (PST)
Received: by mail-vk0-x22e.google.com with SMTP id e6so134553140vkh.2
        for <rtc-linux@googlegroups.com>; Tue, 16 Feb 2016 06:41:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160216012518.GC3310@piout.net>
References: <1455547749-5229-1-git-send-email-akinobu.mita@gmail.com>
	<20160216012518.GC3310@piout.net>
Date: Tue, 16 Feb 2016 23:41:15 +0900
Message-ID: <CAC5umyg2Xt0p-GZzpr-T_ni1=jUQj6up2w=8vux+a7xNZRxh3Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/4] rtc-rx8025: fix irq handler registration
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Wolfgang Grandegger <wg@grandegger.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-02-16 10:25 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> Not completely related to that patch series but I was wondering if you
> had access to that particular RTC.
>
> The rtc-d1307 driver claims to also support rx8025 but my guess is that
> is is not necessary anymore. Could you check which one we should keep?

rx8025 in rtc-ds1307 driver doesn't support alarm, so we should keep
rtc-rx8025.  But rtc-rx8025 driver currently requires both
I2C_FUNC_SMBUS_BYTE_DATA and I2C_FUNC_SMBUS_I2C_BLOCK for i2c adapter
while rx8025 in rtc-ds1307 driver requires one of them.  So we can't
simply remove rx8025 support from rtc-ds1307 now.

Maybe we can introduce emulated read/write_i2c_block_data functions
for this.

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
