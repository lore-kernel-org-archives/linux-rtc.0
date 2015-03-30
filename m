Return-Path: <rtc-linux+bncBCZ273NM4EARBA4N4SUAKGQE2ATOMEQ@googlegroups.com>
Received: from mailgw02.mediatek.com ([210.61.82.184])
        by gmr-mx.google.com with ESMTPS id gb13si984215pac.2.2015.03.30.01.17.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 01:17:07 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 1/3] mfd: provide RTC resource in MT6397 MFD
From: Eddie Huang <eddie.huang@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, Matthias Brugger
	<matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>, Samuel Ortiz
	<sameo@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David
 S. Miller" <davem@davemloft.net>, Greg KH <gregkh@linuxfoundation.org>, Mauro
 Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>,
	Tejun Heo <tj@kernel.org>, Jingoo Han <jg1.han@samsung.com>,
	<linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>
In-Reply-To: <20150318073045.GE3318@x1>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
	 <1426657537-41414-2-git-send-email-eddie.huang@mediatek.com>
	 <20150318073045.GE3318@x1>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2015 16:17:03 +0800
Message-ID: <1427703423.26464.16.camel@mtksdaap41>
MIME-Version: 1.0
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

On Wed, 2015-03-18 at 07:30 +0000, Lee Jones wrote:
> On Wed, 18 Mar 2015, Eddie Huang wrote:
> 
> > Provide MT6397 RTC interrupt, base address, and register in
> > MT6397 MFD.
> > 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/mfd/mt6397-core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index b61c4eb..ef431d8 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -21,9 +21,24 @@
> >  #include <linux/mfd/mt6397/core.h>
> >  #include <linux/mfd/mt6397/registers.h>
> >  
> > +static const struct resource mt6397_rtc_resources[] = {
> > +	{
> > +		.start = 0xe000,
> > +		.end   = 0xe03e,
> 
> I'd like to see these defined please.
> 
Sure, will change to use define next round.

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
