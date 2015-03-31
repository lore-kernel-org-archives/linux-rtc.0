Return-Path: <rtc-linux+bncBCT4XGV33UIBBINS5SUAKGQEHZUCZJI@googlegroups.com>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id l3si1698283pdo.0.2015.03.31.15.01.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 15:01:05 -0700 (PDT)
Date: Tue, 31 Mar 2015 15:01:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones
 <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Matthias
 Brugger <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>, Samuel
 Ortiz <sameo@linux.intel.com>, "David S. Miller" <davem@davemloft.net>,
 Greg KH <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab
 <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Tejun Heo
 <tj@kernel.org>, Jingoo Han <jg1.han@samsung.com>, lkml
 <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Uwe =?ISO-8859-1?Q?Kleine-K=C3=B6ni?=
 =?ISO-8859-1?Q?g?= <kernel@pengutronix.de>, Tianping Fang
 <tianping.fang@mediatek.com>
Subject: [rtc-linux] Re: [PATCH v2 2/3] rtc: mediatek: Add MT6397 RTC driver
Message-Id: <20150331150103.c586821d4fddede12551c9ef@linux-foundation.org>
In-Reply-To: <1427703350.26464.15.camel@mtksdaap41>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
	<1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
	<CAKdAkRSRXZ=1T+2Mfvjc4DsCCt1rxqGZpEuOUkU5KfPD2__BnQ@mail.gmail.com>
	<1427703350.26464.15.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 30 Mar 2015 16:15:50 +0800 Eddie Huang <eddie.huang@mediatek.com> wrote:

> > > +out_rtc:
> > > +       rtc_device_unregister(rtc->rtc_dev);
> > 
> > This is wrong. Whenever you jump to this label the RTC device has not
> > been registered yet.
> 
> Oops, will fix in next round.

Please ensure that Uwe's review comments (starting at
https://lkml.org/lkml/2015/3/17/494) have been addressed.

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
