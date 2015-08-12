Return-Path: <rtc-linux+bncBDS7HNEFSALRBYP6VOXAKGQEFEHJF5Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x20si203514wia.0.2015.08.12.01.10.08
        for <rtc-linux@googlegroups.com>;
        Wed, 12 Aug 2015 01:10:09 -0700 (PDT)
Date: Wed, 12 Aug 2015 10:10:07 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wang Dongsheng <Dongsheng.Wang@freescale.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc/ds3232: fix ds3232 get a WARNING trace in
 resume function
Message-ID: <20150812081007.GZ3411@piout.net>
References: <1436249576-23233-1-git-send-email-dongsheng.wang@freescale.com>
 <20150714225041.GH20482@piout.net>
 <SN1PR0301MB161694E7F5018A10A74DD2AC9D7E0@SN1PR0301MB1616.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <SN1PR0301MB161694E7F5018A10A74DD2AC9D7E0@SN1PR0301MB1616.namprd03.prod.outlook.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 12/08/2015 at 07:50:03 +0000, Wang Dongsheng wrote :
> Hi Belloni,
> 
> I am not found this patch in your tree(rtc-fixes and rtc-next), Need I send v2 patch? :)
> 

Yes, I was expecting that you would send a new version.

> Regards,
> -Dongsheng
> 
> > -----Original Message-----
> > From: Wang Dongsheng-B40534
> > Sent: Wednesday, July 15, 2015 10:06 AM
> > To: 'Alexandre Belloni'
> > Cc: a.zummo@towertech.it; rtc-linux@googlegroups.com; linux-
> > kernel@vger.kernel.org
> > Subject: RE: [PATCH] rtc/ds3232: fix ds3232 get a WARNING trace in resume
> > function
> > 
> > Thanks Belloni. :)
> > 
> > Regards,
> > -Dongsheng
> > 
> > > -----Original Message-----
> > > From: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
> > > Sent: Wednesday, July 15, 2015 6:51 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: a.zummo@towertech.it; rtc-linux@googlegroups.com; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH] rtc/ds3232: fix ds3232 get a WARNING trace in
> > > resume function
> > >
> > > Hi,
> > >
> > > This seems ok, one small nitpick:
> > >
> > > On 07/07/2015 at 14:12:56 +0800, Dongsheng Wang wrote :
> > > > From: Wang Dongsheng <dongsheng.wang@freescale.com> diff --git
> > > > a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c index
> > > > 7e48e53..2081155 100644
> > > > --- a/drivers/rtc/rtc-ds3232.c
> > > > +++ b/drivers/rtc/rtc-ds3232.c
> > > > @@ -463,7 +463,10 @@ static int ds3232_suspend(struct device *dev)
> > > >
> > > >  	if (device_can_wakeup(dev)) {
> > > >  		ds3232->suspended = true;
> > > > -		irq_set_irq_wake(client->irq, 1);
> > > > +		if (irq_set_irq_wake(client->irq, 1)) {
> > > > +			dev_info(dev, "Cannot serve as a wakeup source\n");
> > >
> > > I would use dev_warn_once or dev_info_once here to avoid spamming the
> > > log each time the machine is suspended.
> > >
> > > --
> > > Alexandre Belloni, Free Electrons
> > > Embedded Linux, Kernel and Android engineering
> > > http://free-electrons.com

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
