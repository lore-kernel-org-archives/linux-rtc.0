Return-Path: <rtc-linux+bncBDRMFBMIXEGBB7VN5XAAKGQEFF66PEA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id gg10si3061208pac.1.2016.11.03.08.25.49
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Nov 2016 08:25:49 -0700 (PDT)
Date: Thu, 3 Nov 2016 15:25:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: khilman@baylibre.com, carlo@caione.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RFC PATCH 0/3] ARM64: meson-gxbb: Add support for
 system suspend
Message-ID: <20161103152545.GB25852@remoulade>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Nov 03, 2016 at 03:29:22PM +0100, Neil Armstrong wrote:
> Thie patchset is a very experiment patchset to support the System Suspend
> feature of the Amlogic Meson GX SoCs.
> 
> These SoCs implements system suspend using a non-standard PSCI CPU_SUSPEND
> parameter to enter system suspend.

This sounds like a violation of the CPU_SUSPEND semantics.

> A small driver is added to properly fill the platform_suspend_ops and make
> to correct SMC call.

Ignoring the fact that this is a blatant violation of the PSCI CPU_SUSPEND
semantics, this certainly should not be a separate driver.

> In order to wake up from an alarm, these SoCs have a special memory mapped
> register where an alarm time delay in seconds is stored.
> In order to reuse the RTC wakealarm feature, implement a fake RTC device
> that uses the system time to calculate a delay to write to the register.
> 
> Note that this RFC is here to seek a better way to handle these platform
> specific features.
> 
> Neil Armstrong (3):
>   ARM64: meson: Add Amlogic Meson GX PM Suspend
>   rtc: Add Amlogic Virtual Wake RTC
>   ARM64: dts: meson-gxbb: Add support for PM and Virtual RTC
> 
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |   9 ++
>  drivers/firmware/meson/Kconfig              |   6 +
>  drivers/firmware/meson/Makefile             |   1 +
>  drivers/firmware/meson/meson_gx_pm.c        |  86 +++++++++++++++
>  drivers/rtc/Kconfig                         |  10 ++
>  drivers/rtc/Makefile                        |   1 +
>  drivers/rtc/rtc-meson-vrtc.c                | 164 ++++++++++++++++++++++++++++
>  7 files changed, 277 insertions(+)
>  create mode 100644 drivers/firmware/meson/meson_gx_pm.c
>  create mode 100644 drivers/rtc/rtc-meson-vrtc.c
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
