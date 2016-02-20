Return-Path: <rtc-linux+bncBDS7HNEFSALRBLPUUO3AKGQEGRGNJPY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si621085wmw.3.2016.02.20.15.43.41
        for <rtc-linux@googlegroups.com>;
        Sat, 20 Feb 2016 15:43:41 -0800 (PST)
Date: Sun, 21 Feb 2016 00:42:51 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160220234251.GL2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160220194310.02964d5f@lxorguk.ukuu.org.uk>
 <20160220204715.GJ2222@piout.net>
 <9634631.sIvUQESgNh@wuerfel>
 <20160220231702.GK2222@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160220231702.GK2222@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/02/2016 at 00:17:02 +0100, Alexandre Belloni wrote :
> All the failures seem quite random to me but the reports I get are not
> that precise.
> 
> I know it happens with PCF8523 and that can be true because the
> datasheet says the date is undefined at reset. The handling of the OS
> bit (that bit indicates the date is probably wrong) has to be fixed and
> I will take care of that.
> 
> If that is the only RTC with that particular issue, we clearly don't
> need my workaround. But As I say, I can ask but I don't have a clear
> list of the affected system and their RTC.
> 

I add that it also seem to affect the Allwinner A20 RTC. I'm not sure
how much we can trust the datasheet but it claims the reset value is 0
and I don't think there is a way to know whether the date is correct or
not.


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
