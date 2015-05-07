Return-Path: <rtc-linux+bncBDF47HN2VEIRBDP6VWVAKGQEV4M7TNQ@googlegroups.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com. [209.85.212.169])
        by gmr-mx.google.com with ESMTPS id t6si140578wiz.0.2015.05.07.08.04.44
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 08:04:44 -0700 (PDT)
Received: by mail-wi0-f169.google.com with SMTP id di4so63431616wid.0
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 08:04:44 -0700 (PDT)
Date: Thu, 7 May 2015 16:04:40 +0100
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [rtc-linux] Re: [STLinux Kernel] [PATCH 02/12] clocksource: sti:
 Provide support for the ST LPC Clocksource IP
Message-ID: <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Lee,

On Thu, 07 May 2015, Lee Jones wrote:

> This IP is shared with Watchdog and RTC functionality.  Only one of
> these IPs can be used at the same time.  We use the device-driver
> model combined with a DT 'mode' property to enforce this.

Which means my previous assertion in V1 that the IP didn't exist on stih415/6
SoC is most likely wrong, as the watchdog driver has bindings already for those
platforms.

I did try this before and couldn't get it working (driver failed on clk_get_rate)
on stih416-b2020.

Did you try and see if you can get this also working for stih415/6 SoCs? It would
mean we can move away from arm_global_timer for all upstreamed STI platforms.

regards,

Peter.

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
