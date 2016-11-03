Return-Path: <rtc-linux+bncBDRMFBMIXEGBBNNW5XAAKGQEJ5HLFNQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id p14si1287836pfl.0.2016.11.03.08.43.49
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Nov 2016 08:43:49 -0700 (PDT)
Date: Thu, 3 Nov 2016 15:43:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, khilman@baylibre.com,
	linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com,
	carlo@caione.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [RFC PATCH 0/3] ARM64: meson-gxbb: Add support for
 system suspend
Message-ID: <20161103154336.GE25852@remoulade>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <20161103152545.GB25852@remoulade>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161103152545.GB25852@remoulade>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Urrgh, I accidentally sent this when trying to save this to my drafts folder;
sorry for the half-finished reply.

On Thu, Nov 03, 2016 at 03:25:46PM +0000, Mark Rutland wrote:
> On Thu, Nov 03, 2016 at 03:29:22PM +0100, Neil Armstrong wrote:
> > Thie patchset is a very experiment patchset to support the System Suspend
> > feature of the Amlogic Meson GX SoCs.
> > 
> > These SoCs implements system suspend using a non-standard PSCI CPU_SUSPEND
> > parameter to enter system suspend.

> > Note that this RFC is here to seek a better way to handle these platform
> > specific features.

One of the reasons that we want PSCI is that it is a standard interface across
platforms. Generally, we do not want platform-specific interfaces.

In this case, PSCI 1.0+ has SYSTEM_SUSPEND for this purpose.

If PSCI is lacking functionality that vendors want, they should speak to ARM
w.r.t. the PSCI specification -- it can be extended with new functionality as
has already happened with PSCI 0.2 and PSCI 1.0.

Thanks,
Mark.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
