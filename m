Return-Path: <rtc-linux+bncBCZ273NM4EARBU4YU2VAKGQERI523RY@googlegroups.com>
Received: from mailgw02.mediatek.com ([210.61.82.184])
        by gmr-mx.google.com with ESMTPS id dv5si2678849pbb.0.2015.05.05.20.36.50
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 20:36:51 -0700 (PDT)
Message-ID: <1430883407.28521.4.camel@mtksdaap41>
Subject: Re: [rtc-linux] [PATCH v3 3/3] MAINTAINERS: add Mediatek RTC driver
From: Eddie Huang <eddie.huang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, Samuel Ortiz
	<sameo@linux.intel.com>, <srv_heupstream@mediatek.com>,
	<rtc-linux@googlegroups.com>, Greg KH <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
	<linux-mediatek@lists.infradead.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe
 Perches" <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, "Lee
 Jones" <lee.jones@linaro.org>, <linux-arm-kernel@lists.infradead.org>
Date: Wed, 6 May 2015 11:36:47 +0800
In-Reply-To: <20150505200352.GQ4276@piout.net>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
	 <1430206556-18254-4-git-send-email-eddie.huang@mediatek.com>
	 <20150505200352.GQ4276@piout.net>
Content-Type: text/plain; charset=UTF-8
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

Hi Alexandre,

On Tue, 2015-05-05 at 22:03 +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 28/04/2015 at 15:35:56 +0800, Eddie Huang wrote :
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2e5bbc0..eb80610 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1223,6 +1223,13 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
> >  S:	Maintained
> >  F:	arch/arm/mach-orion5x/ts78xx-*
> >  
> > +ARM/Mediatek RTC DRIVER
> > +M:	Eddie Huang <eddie.huang@mediatek.com>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	drivers/rtc/rtc-mt*
> 
> I feel like this is a bit broad. Unless you want to really maintain
> rtc-mt* which I guess may not be only Mediatek in the future, I would
> use the full filename here. You will probably remember to update it if
> you add more, that may not be the case for other developers.
> 
Yes, you are right, the rtc-mt* is too broad, use full filename is a
better choice right now.

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
