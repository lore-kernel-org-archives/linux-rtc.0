Return-Path: <rtc-linux+bncBCPM5SUWUYIRBIFH423AKGQEUGU34BI@googlegroups.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id c66si125392vkf.0.2016.03.04.05.54.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2016 05:54:40 -0800 (PST)
Received: by mail-vk0-x242.google.com with SMTP id c3so3910913vkb.0
        for <rtc-linux@googlegroups.com>; Fri, 04 Mar 2016 05:54:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160303230833.GB2587@piout.net>
References: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
	<20160303230833.GB2587@piout.net>
Date: Fri, 4 Mar 2016 22:54:39 +0900
Message-ID: <CAC5umyjz-hx6YHxV8-J46TbLSBK0FHdBT2yiMcxSfWdLfM9JHA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 1/8] rtc: ds3232: rename rtc-ds3232.c to
 rtc-ds3232-core.c for preparation
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Dennis Aberilla <denzzzhome@yahoo.com>
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

2016-03-04 8:08 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
>
> Hi,
>
> I'm fine with the patches (apart from patch 7/8) but I'd like to request
> one more change. Could actually support both the ds3232 and the ds3234
> in the same file? That will nicely reduce the number of lines and remove
> the need for an include.
>
> For an example, you can have a look at sound/soc/codecs/wm8750.c

Sounds good.  I'll try.
Maybe we also need a trick like CONFIG_SND_SOC_I2C_AND_SPI for rtc.

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
