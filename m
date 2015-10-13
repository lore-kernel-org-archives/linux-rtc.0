Return-Path: <rtc-linux+bncBDS7HNEFSALRBQGN6WYAKGQEHO6X6DQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hs5si811278wib.1.2015.10.13.13.17.04
        for <rtc-linux@googlegroups.com>;
        Tue, 13 Oct 2015 13:17:04 -0700 (PDT)
Date: Tue, 13 Oct 2015 22:17:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Georg.Soffel@bosch-si.com,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: pcf8563: disable CLKOUT
Message-ID: <20151013201703.GA3421@piout.net>
References: <1444712938-22865-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1444712938-22865-1-git-send-email-hs@denx.de>
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

On 13/10/2015 at 07:08:58 +0200, Heiko Schocher wrote :
> Disable the CLKOUT of the RTC after power-up.
> After power-up/reset of the RTC, CLKOUT is enabled by default,
> with CLKOUT enabled the RTC chip has 2-3 times higher power
> consumption. If you do not need CLKOUT, you can disable the
> CLKOUT with setting "disable-clkout" property.
> 

I think you can simply unconditionally disable clkout. My preferred way
of doing what you suggest is probably to register a clock in the CCF. If
the clock is not used, it will be automatically disabled.
It will also provide a generic way of setting the clkout frequency (some
RTC are able to output 32kHZ, 1kHz and 1Hz).

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
