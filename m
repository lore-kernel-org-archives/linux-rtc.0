Date: Fri, 22 Jan 2016 01:07:28 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael Lange <linuxstuff@milaw.biz>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: ds1307.c: add support for the DT
 property 'wakeup-source'
Message-ID: <20160122000728.GE3608@piout.net>
References: <1453396216-8367-1-git-send-email-linuxstuff@milaw.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453396216-8367-1-git-send-email-linuxstuff@milaw.biz>
List-ID: <rtc-linux.googlegroups.com>

Hi,

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

I don't think setting uie_unsupported is necessary because the alarm
functions will fail anyway. What kind of issue did you have?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
