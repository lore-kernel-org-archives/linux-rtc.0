Return-Path: <rtc-linux+bncBAABBEMAS6WQKGQE4X2ACDY@googlegroups.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1on0130.outbound.protection.outlook.com. [157.56.110.130])
        by gmr-mx.google.com with ESMTPS id j14si301069ywa.5.2015.07.14.19.06.08
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jul 2015 19:06:08 -0700 (PDT)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH] rtc/ds3232: fix ds3232 get a WARNING trace in
 resume function
Date: Wed, 15 Jul 2015 02:06:06 +0000
Message-ID: <SN1PR0301MB1616B0FACCF377D8C476BE419D9A0@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1436249576-23233-1-git-send-email-dongsheng.wang@freescale.com>
 <20150714225041.GH20482@piout.net>
In-Reply-To: <20150714225041.GH20482@piout.net>
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

Thanks Belloni. :)

Regards,
-Dongsheng

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
> Sent: Wednesday, July 15, 2015 6:51 AM
> To: Wang Dongsheng-B40534
> Cc: a.zummo@towertech.it; rtc-linux@googlegroups.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] rtc/ds3232: fix ds3232 get a WARNING trace in resume
> function
> 
> Hi,
> 
> This seems ok, one small nitpick:
> 
> On 07/07/2015 at 14:12:56 +0800, Dongsheng Wang wrote :
> > From: Wang Dongsheng <dongsheng.wang@freescale.com> diff --git
> > a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c index
> > 7e48e53..2081155 100644
> > --- a/drivers/rtc/rtc-ds3232.c
> > +++ b/drivers/rtc/rtc-ds3232.c
> > @@ -463,7 +463,10 @@ static int ds3232_suspend(struct device *dev)
> >
> >  	if (device_can_wakeup(dev)) {
> >  		ds3232->suspended = true;
> > -		irq_set_irq_wake(client->irq, 1);
> > +		if (irq_set_irq_wake(client->irq, 1)) {
> > +			dev_info(dev, "Cannot serve as a wakeup source\n");
> 
> I would use dev_warn_once or dev_info_once here to avoid spamming the log each
> time the machine is suspended.
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com

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
