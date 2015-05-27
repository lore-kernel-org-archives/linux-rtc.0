Return-Path: <rtc-linux+bncBCV3TM5A74DRBB7JS2VQKGQE2OENMEA@googlegroups.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com. [209.85.192.169])
        by gmr-mx.google.com with ESMTPS id x3si1768981pdh.2.2015.05.27.05.11.50
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 05:11:50 -0700 (PDT)
Received: by pdfh10 with SMTP id h10so12239121pdf.3
        for <rtc-linux@googlegroups.com>; Wed, 27 May 2015 05:11:50 -0700 (PDT)
Date: Wed, 27 May 2015 20:10:53 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
	alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5 0/6] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
Message-ID: <20150527121052.GH16165@dragon>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li@freescale.com wrote:
> Frank Li (5):
>   rtc: arm: imx: snvs: change use syscon to access register
>   Document: dt: fsl: snvs: change support syscon
>   ARM: dts: imx: update snvs to use syscon access register
>   Document: devicetree: input: imx: i.mx snvs power device tree bindings
>   ARM: dts: imx6sx: enable snvs power key
> 
> Robin Gong (1):
>   input: keyboard: imx: add snvs power key driver

The series looks fine to me now.  But I can only apply those two dts
patches after the driver and binding parts get landed on mainline.
Hopefully, you can get them in during the coming merge window through
subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
out.

Shawn

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
