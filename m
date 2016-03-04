Return-Path: <rtc-linux+bncBDS7HNEFSALRBNVW423AKGQEVSNVGTQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si111765wmw.3.2016.03.04.06.27.02
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Mar 2016 06:27:02 -0800 (PST)
Date: Fri, 4 Mar 2016 15:26:42 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] Re: [PATCH v3 1/8] rtc: ds3232: rename rtc-ds3232.c to
 rtc-ds3232-core.c for preparation
Message-ID: <20160304142642.GC27662@piout.net>
References: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
 <20160303230833.GB2587@piout.net>
 <CAC5umyjz-hx6YHxV8-J46TbLSBK0FHdBT2yiMcxSfWdLfM9JHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAC5umyjz-hx6YHxV8-J46TbLSBK0FHdBT2yiMcxSfWdLfM9JHA@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/03/2016 at 22:54:39 +0900, Akinobu Mita wrote :
> 2016-03-04 8:08 GMT+09:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
> >
> > Hi,
> >
> > I'm fine with the patches (apart from patch 7/8) but I'd like to request
> > one more change. Could actually support both the ds3232 and the ds3234
> > in the same file? That will nicely reduce the number of lines and remove
> > the need for an include.
> >
> > For an example, you can have a look at sound/soc/codecs/wm8750.c
> 
> Sounds good.  I'll try.
> Maybe we also need a trick like CONFIG_SND_SOC_I2C_AND_SPI for rtc.

Yes, feel free to add that in the Kconfig and create a new section for
RTCs that are both I2C and SPI if this is needed.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
