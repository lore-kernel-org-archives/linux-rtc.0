Date: Thu, 23 Feb 2017 13:14:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michal Simek <monstr@monstr.eu>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] RTC used as a module
Message-ID: <20170223121426.i24ssrlwitrvb32h@piout.net>
References: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
List-ID: <rtc-linux.googlegroups.com>

Hi Michal,

I've been thinking about this issue (and meaning to actually test).

On 08/12/2016 at 14:02:36 +0100, Michal Simek wrote:
> Hi guys,
> 
> I am trying to find out reason for this behavior. If rtc-zynqmp is used
> as module for the first time it is correctly probed based on aliases
> setting. (rtc5 for log below). But then driver is removed and add again
> rtc5 is still not freed. rtc_device_release() is not called that's why
> rtc->id can't be used again.
> 
> sh-4.3# modprobe rtc-zynqmp
> [   42.468565] rtc_zynqmp ffa60000.rtc: rtc core: registered
> ffa60000.rtc as rtc5
> sh-4.3# rmmod rtc-zynqmp
> sh-4.3# modprobe rtc-zynqmp
> [   48.648222] rtc_zynqmp ffa60000.rtc: /aliases ID 5 not available
> [   48.654280] rtc_zynqmp ffa60000.rtc: rtc core: registered
> ffa60000.rtc as rtc0
> 
> 
> I didn't try different rtc drivers but it looks like that someone keeps
> reference that's why release function is not called.
> 
> Can someone check this with different RTC module?

I'll do that soon.

> Or is this expected behavior?
> 

I don't think so :)

Can you clarify a few things:
 - is this the only rtc with a driver on your system ?
 - is it selected as the RTC_SYSTOHC_DEVICE or RTC_HCTOSYS_DEVICE. I've
   checked the code and I don't think this is the issue but it is worth
testing.

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
