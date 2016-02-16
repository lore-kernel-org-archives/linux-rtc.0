Return-Path: <rtc-linux+bncBCGLJQVNREJBBUODRS3AKGQEN23PQPA@googlegroups.com>
Received: from mailgw02.hq.mediatek.com ([210.61.82.184])
        by gmr-mx.google.com with ESMTP id u66si3594544pfa.2.2016.02.16.05.19.13
        for <rtc-linux@googlegroups.com>;
        Tue, 16 Feb 2016 05:19:13 -0800 (PST)
Message-ID: <1455628747.2981.4.camel@mtksdaap41>
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: Add platform device ID table
From: Eddie Huang <eddie.huang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, Javier Martinez Canillas
	<javier@osg.samsung.com>, Alessandro Zummo <a.zummo@towertech.it>,
	<rtc-linux@googlegroups.com>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>
Date: Tue, 16 Feb 2016 21:19:07 +0800
In-Reply-To: <2416670.q30ahHlzPm@wuerfel>
References: <1455016095-13724-1-git-send-email-javier@osg.samsung.com>
	 <1455501497.7263.4.camel@mtksdaap41> <56C1E5C8.6040007@osg.samsung.com>
	 <2416670.q30ahHlzPm@wuerfel>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 2016-02-16 at 12:37 +0100, Arnd Bergmann wrote:
> On Monday 15 February 2016 11:50:48 Javier Martinez Canillas wrote:
> > 
> > On 02/14/2016 10:58 PM, Eddie Huang wrote:
> > 
> > [snip]
> > 
> > >> @@ -412,6 +418,7 @@ static struct platform_driver mtk_rtc_driver = {
> > >>      },
> > >>      .probe  = mtk_rtc_probe,
> > >>      .remove = mtk_rtc_remove,
> > >> +    .id_table = mt6397_rtc_id,
> > >>   };
> > >>
> > >>   module_platform_driver(mtk_rtc_driver);
> > >> @@ -419,4 +426,3 @@ module_platform_driver(mtk_rtc_driver);
> > >>   MODULE_LICENSE("GPL v2");
> > >>   MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
> > >>   MODULE_DESCRIPTION("RTC Driver for MediaTek MT6397 PMIC");
> > >> -MODULE_ALIAS("platform:mt6397-rtc");
> > >
> > > This patch looks good to me, but I am wondering, since we tend to use
> > > device tree method to match driver, do we still need support platform
> > > device ID ?
> > >
> > 
> > I'm not familiar with neither this IP block nor the SoC so it is up to
> > you. I just noticed this issue when reviewing a regulator driver for a
> > similar PMIC posted by someone from mediatek.
> > 
> > I thought platform device was needed since the driver has a MODULE_ALIAS()
> > but please let me know what you prefer and I can re-spin the patch and
> > just remove the MODULE_ALIAS() if that makes more sense for this platform.
> >   
> > 
> 
> I agree. We can alway add a MODULE_DEVICE_TABLE() if we get multiple
> users of this driver on architectures that don't use devicetree yet.
> 

Sure. Thanks the patch to add expandability to this driver.

Acked-by: Eddie Huang <eddie.huang@mediatek.com>

Eddie


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
