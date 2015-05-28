Return-Path: <rtc-linux+bncBDS7HNEFSALRBA4NTSVQKGQENVL7ZLI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si121155wib.2.2015.05.28.05.13.55
        for <rtc-linux@googlegroups.com>;
        Thu, 28 May 2015 05:13:55 -0700 (PDT)
Date: Thu, 28 May 2015 14:13:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Frank.Li@freescale.com, lznuaa@gmail.com, dmitry.torokhov@gmail.com,
	robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5 0/6] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
Message-ID: <20150528121353.GP2185@piout.net>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <20150527121052.GH16165@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150527121052.GH16165@dragon>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 27/05/2015 at 20:10:53 +0800, Shawn Guo wrote :
> On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li@freescale.com wrote:
> > Frank Li (5):
> >   rtc: arm: imx: snvs: change use syscon to access register
> >   Document: dt: fsl: snvs: change support syscon
> >   ARM: dts: imx: update snvs to use syscon access register
> >   Document: devicetree: input: imx: i.mx snvs power device tree bindings
> >   ARM: dts: imx6sx: enable snvs power key
> > 
> > Robin Gong (1):
> >   input: keyboard: imx: add snvs power key driver
> 
> The series looks fine to me now.  But I can only apply those two dts
> patches after the driver and binding parts get landed on mainline.
> Hopefully, you can get them in during the coming merge window through
> subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
> out.
> 

Actually, I was thinking you could take the whole series in your tree
(at least, I'm speaking for the RTC part).
Else, I'm wondering who should take the documentation changes.


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
