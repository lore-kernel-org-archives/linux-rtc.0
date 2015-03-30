Return-Path: <rtc-linux+bncBCZ273NM4EARBSMM4SUAKGQEQVAHSQI@googlegroups.com>
Received: from mailgw01.mediatek.com ([210.61.82.183])
        by gmr-mx.google.com with ESMTPS id pc4si1021382pac.0.2015.03.30.01.16.08
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 01:16:09 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 2/3] rtc: mediatek: Add MT6397 RTC driver
From: Eddie Huang <eddie.huang@mediatek.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Matthias Brugger <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg KH
	<gregkh@linuxfoundation.org>, Mauro Carvalho Chehab
	<mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Tejun Heo
	<tj@kernel.org>, Jingoo Han <jg1.han@samsung.com>, lkml
	<linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>, Tianping Fang
	<tianping.fang@mediatek.com>
In-Reply-To: <CAKdAkRSRXZ=1T+2Mfvjc4DsCCt1rxqGZpEuOUkU5KfPD2__BnQ@mail.gmail.com>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
	 <1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
	 <CAKdAkRSRXZ=1T+2Mfvjc4DsCCt1rxqGZpEuOUkU5KfPD2__BnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2015 16:15:50 +0800
Message-ID: <1427703350.26464.15.camel@mtksdaap41>
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

Hi Dmitry,

On Fri, 2015-03-20 at 22:25 -0700, Dmitry Torokhov wrote:
> Hi Eddie,
> 
> 
> On Tue, Mar 17, 2015 at 10:45 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> > +static int mtk_rtc_probe(struct platform_device *pdev)
> > +{
> > +       struct resource *res;
> > +       struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
> > +       struct mt6397_rtc *rtc;
> > +       int ret = 0;
> > +
> > +       rtc = devm_kzalloc(&pdev->dev, sizeof(struct mt6397_rtc), GFP_KERNEL);
> > +       if (!rtc)
> > +               return -ENOMEM;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       rtc->addr_base = res->start;
> > +       rtc->addr_range = res->end - res->start;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +       rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> > +       if (rtc->irq <= 0)
> > +               goto out_rtc;
> > +
> > +       rtc->regmap = mt6397_chip->regmap;
> > +       rtc->dev = &pdev->dev;
> > +       mutex_init(&rtc->lock);
> > +
> > +       platform_set_drvdata(pdev, rtc);
> > +
> > +       ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> > +                       mtk_rtc_irq_handler_thread,
> > +                       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +                       "mt6397-rtc", rtc);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> > +                       rtc->irq, ret);
> > +               goto out_rtc;
> > +       }
> > +
> > +       rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> > +                               &mtk_rtc_ops, THIS_MODULE);
> > +       if (IS_ERR(rtc->rtc_dev)) {
> > +               dev_err(&pdev->dev, "register rtc device failed\n");
> > +               return PTR_ERR(rtc->rtc_dev);
> > +       }
> > +
> > +       device_init_wakeup(&pdev->dev, 1);
> > +
> > +       return 0;
> > +
> > +out_rtc:
> > +       rtc_device_unregister(rtc->rtc_dev);
> 
> This is wrong. Whenever you jump to this label the RTC device has not
> been registered yet.

Oops, will fix in next round.

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
