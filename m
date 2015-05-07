Return-Path: <rtc-linux+bncBCZ273NM4EARB6X6VWVAKGQEP3V7YBI@googlegroups.com>
Received: from mailgw02.mediatek.com ([210.61.82.184])
        by gmr-mx.google.com with ESMTPS id ei3si286077pdb.1.2015.05.07.08.06.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 May 2015 08:06:33 -0700 (PDT)
Message-ID: <1431011187.16884.0.camel@mtksdaap41>
Subject: [rtc-linux] Re: [PATCH v4 2/3] rtc: mediatek: Add MT6397 RTC driver
From: Eddie Huang <eddie.huang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Joe Perches <joe@perches.com>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>, <srv_heupstream@mediatek.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Greg
 KH" <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tejun Heo <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Sascha Hauer <kernel@pengutronix.de>, Tomasz Figa <tfiga@google.com>,
	Tianping Fang <tianping.fang@mediatek.com>
Date: Thu, 7 May 2015 23:06:27 +0800
In-Reply-To: <20150507120601.GH3465@piout.net>
References: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
	 <1430897022-63357-3-git-send-email-eddie.huang@mediatek.com>
	 <1430898299.9365.74.camel@perches.com> <20150507120601.GH3465@piout.net>
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

On Thu, 2015-05-07 at 14:06 +0200, Alexandre Belloni wrote:
> On 06/05/2015 at 00:44:59 -0700, Joe Perches wrote :
> > On Wed, 2015-05-06 at 15:23 +0800, Eddie Huang wrote:
> > > From: Tianping Fang <tianping.fang@mediatek.com>
> > 
> > trivia: no need to resend now, maybe in a future patch.
> > 
> > > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > []
> > > +static int mtk_rtc_probe(struct platform_device *pdev)
> > > +{
> > []
> > > +	ret = request_threaded_irq(rtc->irq, NULL,
> > > +				   mtk_rtc_irq_handler_thread,
> > > +				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > > +			"mt6397-rtc", rtc);
> > 
> > It'd be nicer to align all the statement lines
> > to that open parenthesis
> > 
> > 
> 
> I'll fix it up when applying.
> 
Thanks your great help

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
