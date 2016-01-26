Return-Path: <rtc-linux+bncBDS7HNEFSALRBQW3TS2QKGQEBJZBBWA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c140si235603wmh.0.2016.01.26.00.26.42
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 00:26:42 -0800 (PST)
Date: Tue, 26 Jan 2016 09:26:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael Lange <linuxstuff@milaw.biz>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: ds1307.c: add support for the DT
 property 'wakeup-source'
Message-ID: <20160126082641.GE11740@piout.net>
References: <1453396216-8367-1-git-send-email-linuxstuff@milaw.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1453396216-8367-1-git-send-email-linuxstuff@milaw.biz>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/01/2016 at 18:10:16 +0100, Michael Lange wrote :
> For RTC chips with no IRQ directly connected to the SoC, the RTC chip
> can be forced as a wakeup source by stating that explicitly in
> the device's .dts file using the "wakeup-source" boolean property.
> This will guarantee the 'wakealarm' sysfs entry is available on the
> device, if supported by the RTC.
> 
> With these changes to the driver rtc-ds1307 and the necessary entries
> in the .dts file, I get an working ds1337 RTC on the Witty Pi extension
> board by UUGear for the Raspberry Pi.
> 
> An example for the entry in the .dts file:
> 
> 	rtc: ds1337@68 {
> 		compatible = "dallas,ds1337";
> 		reg = <0x68>;
> 		wakeup-source;
> 
> If the "wakeup-source" property is set, do not request an IRQ.
> Set also UIE mode to unsupported, to get a working 'hwclock' binary.
> 
> Signed-off-by: Michael Lange <linuxstuff@milaw.biz>
Applied, thanks.

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
