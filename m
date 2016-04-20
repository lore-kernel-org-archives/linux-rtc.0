Return-Path: <rtc-linux+bncBCPM5SUWUYIRBCHW3W4AKGQE5HJE3FQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-vk0-x22e.google.com (mail-vk0-x22e.google.com. [2607:f8b0:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id w11si324341vkw.0.2016.04.20.05.50.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 05:50:16 -0700 (PDT)
Received: by mail-vk0-x22e.google.com with SMTP id t129so56768229vkg.2
        for <rtc-linux@googlegroups.com>; Wed, 20 Apr 2016 05:50:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461120650-4861-1-git-send-email-Qianyu.Gong@nxp.com>
References: <1461120650-4861-1-git-send-email-Qianyu.Gong@nxp.com>
Date: Wed, 20 Apr 2016 21:50:16 +0900
Message-ID: <CAC5umyjhOywuviYm4aMTM1_Y_xrb=hLoROtZ6YMvG9BBru5Jcw@mail.gmail.com>
Subject: [rtc-linux] Re: [Patch v2] rtc: ds3232: fix call trace when
 rtc->ops_lock is used as NULL
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Gong Qianyu <Qianyu.Gong@nxp.com>
Cc: rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Gong,

2016-04-20 11:50 GMT+09:00 Gong Qianyu <Qianyu.Gong@nxp.com>:
> Move devm_rtc_device_register() just before registering irq handler
> to initialize rtc->ops_lock earlier.

I'd prefer the patch description to have a bit more details as I said
in the last email.  But the actual change in this patch now looks good
to me.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks for testing and fix.

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
