Return-Path: <rtc-linux+bncBCF6L7545UEBBLNKR7DQKGQEWW2L5TA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from kirsty.vergenet.net (kirsty.vergenet.net. [202.4.237.240])
        by gmr-mx.google.com with ESMTP id r66si2712212pfb.7.2017.04.04.10.17.33
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Apr 2017 10:17:33 -0700 (PDT)
Date: Tue, 4 Apr 2017 13:17:28 -0400
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: chris.brandt@renesas.com, geert@linux-m68k.org, robh+dt@kernel.org,
	mark.rutland@arm.com, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] arm: dts: genmai: Enable rtc and rtc_x1 clock
Message-ID: <20170404171728.GB14047@verge.net.au>
References: <1491235398-26549-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1491235398-26549-1-git-send-email-jacopo+renesas@jmondi.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Apr 03, 2017 at 06:03:18PM +0200, Jacopo Mondi wrote:
> Enable the 32.768 kHz RTC_X1 clock by setting the frequency value to
> non-zero and enable the realtime clock.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> 
> This patch depends on Chris Brandt's series
> "rtc: Reuse rtc-sh driver to support RZ/A1"
> Please queue this on top of that.

Thanks, done.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
