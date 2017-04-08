Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIH7UPDQKGQEXKUFTDA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id p14si218532wmi.2.2017.04.08.08.20.00
        for <rtc-linux@googlegroups.com>;
        Sat, 08 Apr 2017 08:20:00 -0700 (PDT)
Date: Sat, 8 Apr 2017 17:19:59 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Agner <stefan@agner.ch>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: support m41t0 variant
Message-ID: <20170408151959.27oh2xhrnvoabb5d@piout.net>
References: <20170323235457.13223-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170323235457.13223-1-stefan@agner.ch>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/03/2017 at 16:54:57 -0700, Stefan Agner wrote:
> The m41t0 variant is very similar to the already supported m41t00
> variant, with the notable exception of the oscillator fail bit.
> The data sheet notes:
> 
>   If the oscillator fail (OF) bit is internally set to a '1,' this
>   indicates that the oscillator has either stopped, or was stopped
>   for some period of time and can be used to judge the validity of
>   the clock and date data.
> 
> The bit will get cleared with a regular write of the system time,
> so no changes are needed to clear it.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt |  1 +
>  drivers/rtc/rtc-ds1307.c                                  | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
