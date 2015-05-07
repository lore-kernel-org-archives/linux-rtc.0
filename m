Return-Path: <rtc-linux+bncBDA7X7F2WUEBBWHSV2VAKGQEBXNDKOA@googlegroups.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com. [74.125.82.47])
        by gmr-mx.google.com with ESMTPS id bc3si316015wib.2.2015.05.07.12.13.28
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 12:13:28 -0700 (PDT)
Received: by mail-wg0-f47.google.com with SMTP id u9so52992784wgi.3
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 12:13:28 -0700 (PDT)
Date: Thu, 7 May 2015 20:13:24 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [rtc-linux] Re: [STLinux Kernel] [PATCH 02/12] clocksource: sti:
 Provide support for the ST LPC Clocksource IP
Message-ID: <20150507191324.GB16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
 <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> > This IP is shared with Watchdog and RTC functionality.  Only one of
> > these IPs can be used at the same time.  We use the device-driver
> > model combined with a DT 'mode' property to enforce this.
>=20
> Which means my previous assertion in V1 that the IP didn't exist on stih4=
15/6
> SoC is most likely wrong, as the watchdog driver has bindings already for=
 those
> platforms.
>=20
> I did try this before and couldn't get it working (driver failed on clk_g=
et_rate)
> on stih416-b2020.
>=20
> Did you try and see if you can get this also working for stih415/6 SoCs? =
It would
> mean we can move away from arm_global_timer for all upstreamed STI platfo=
rms.

This patch-set only supports STiH4{07,10}, which is the only platform
it's been tested on until this point.  I can investigate porting it to
Orly/Orly2 as a subsequent piece of work if it's going to be useful
for ST.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
