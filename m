Return-Path: <rtc-linux+bncBDS7HNEFSALRBZ7P4C3AKGQETP2XXYA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si291315wmd.0.2016.03.03.05.11.02
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Mar 2016 05:11:02 -0800 (PST)
Date: Thu, 3 Mar 2016 13:57:38 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: cvs268@gmail.com
Cc: rtc-linux <rtc-linux@googlegroups.com>, a.zummo@towertech.it,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	s.trumtrar@pengutronix.de
Subject: [rtc-linux] Re: [PATCH v4 2/2] rtc: add driver for RX6110SA real time clock
Message-ID: <20160303125738.GD2567@piout.net>
References: <1451927075-8656-1-git-send-email-s.trumtrar@pengutronix.de>
 <1451927075-8656-2-git-send-email-s.trumtrar@pengutronix.de>
 <20160131115457.GL20165@piout.net>
 <20160131140418.GD11885@pengutronix.de>
 <6c5c65d7-2cee-4e3f-a91c-c9fbd4c006c7@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6c5c65d7-2cee-4e3f-a91c-c9fbd4c006c7@googlegroups.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 03/03/2016 at 03:58:45 -0800, cvs268@gmail.com wrote :
>  
> 
> > > > If the need ever arises to also support the I2C variant, this driver 
> > > > could easily be refactored to support both cases. 
> >
> I will soon be getting an embedded board with this RX6110 RTC on it 
> connected via I2C.
> So i would like to take-up the task of adding I2C support in a few weeks.
> 
> A quick search shows drivers/rtc/rtc-rx4581.c was similarly written based 
> on drivers/rtc/rtc-rx8581.c
> 
> Q. Should i proceed to create drivers/rtc/rtc-rx6110-i2c.c or whats the 
> recommended approach?
> I did not find any RTC driver that supports both i2c and spi (eg. depending 
> upon some config option)
> 

You can have a look at sound/soc/codecs/wm8750.c which register one
driver for both i2c and spi. It is simple enough and you should be able
to do the same.

Obviously, a new category will be needed in the Kconfig to handle RTC
that are both spi and i2c with the same part number.


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
