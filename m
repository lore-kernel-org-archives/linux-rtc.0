Return-Path: <rtc-linux+bncBDS7HNEFSALRBKVKVWVAKGQEUKAT6GY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k2si258691wif.0.2015.05.07.05.06.02
        for <rtc-linux@googlegroups.com>;
        Thu, 07 May 2015 05:06:02 -0700 (PDT)
Date: Thu, 7 May 2015 14:06:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>,
	Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	srv_heupstream@mediatek.com, Samuel Ortiz <sameo@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Tomasz Figa <tfiga@google.com>,
	Tianping Fang <tianping.fang@mediatek.com>
Subject: [rtc-linux] Re: [PATCH v4 2/3] rtc: mediatek: Add MT6397 RTC driver
Message-ID: <20150507120601.GH3465@piout.net>
References: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
 <1430897022-63357-3-git-send-email-eddie.huang@mediatek.com>
 <1430898299.9365.74.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430898299.9365.74.camel@perches.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 06/05/2015 at 00:44:59 -0700, Joe Perches wrote :
> On Wed, 2015-05-06 at 15:23 +0800, Eddie Huang wrote:
> > From: Tianping Fang <tianping.fang@mediatek.com>
> 
> trivia: no need to resend now, maybe in a future patch.
> 
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> []
> > +static int mtk_rtc_probe(struct platform_device *pdev)
> > +{
> []
> > +	ret = request_threaded_irq(rtc->irq, NULL,
> > +				   mtk_rtc_irq_handler_thread,
> > +				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +			"mt6397-rtc", rtc);
> 
> It'd be nicer to align all the statement lines
> to that open parenthesis
> 
> 

I'll fix it up when applying.


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
