Return-Path: <rtc-linux+bncBDS7HNEFSALRB2HA4GZAKGQE7M6PN5A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d185si238583wmf.0.2015.11.27.07.01.59
        for <rtc-linux@googlegroups.com>;
        Fri, 27 Nov 2015 07:01:59 -0800 (PST)
Date: Fri, 27 Nov 2015 16:01:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH] rtc-da9063: avoid writing undefined data to rtc
Message-ID: <20151127150158.GC4268@piout.net>
References: <1448625775-15531-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448625775-15531-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 27/11/2015 at 13:02:55 +0100, Enrico Scholz wrote :
> driver did
> 
> | static void da9063_tm_to_data(struct rtc_time *tm, u8 *data,
> | {
> |  	const struct da9063_compatible_rtc_regmap *config = rtc->config;
> |
> | 	data[RTC_SEC] &= ~config->rtc_count_sec_mask;
> | 	data[RTC_SEC] |= tm->tm_sec & config->rtc_count_sec_mask;
> | ...
> | }
> | ...
> | static int da9063_rtc_set_time(struct device *dev, struct rtc_time *tm)
> | {
> |       ...
> |	u8 data[RTC_DATA_LEN];
> |	int ret;
> |
> |	da9063_tm_to_data(tm, data, rtc);
> 
> which means that some bits of stack content (in 'data[]') was masked out
> and written to the RTC.
> 
> Because da9063_tm_to_data() is used only by da9063_rtc_set_time() and
> da9063_rtc_set_alarm(), we can write fields directly.
> 

Unfortunately, the datasheets are behind a register wall and I can't
check. Is there any meaningful bits mixed in the date/time registers?

I think this was intended to keep those bits to their previous value but
this is not yet implemented.

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
