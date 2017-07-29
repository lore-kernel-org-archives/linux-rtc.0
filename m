Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50448 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdG2Wia (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 29 Jul 2017 18:38:30 -0400
Date: Sun, 30 Jul 2017 00:38:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-stmp3xxx: detect power failure on backup power
 domain
Message-ID: <20170729223828.kklvkcqwvsscmfuf@piout.net>
References: <20170518144521.9294-1-michael.thalmeier@hale.at>
 <20170518155631.kcbkr6ldxailkg7i@piout.net>
 <20170607130503.GA32452@entw49.hale>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170607130503.GA32452@entw49.hale>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/06/2017 at 15:05:03 +0200, Michael Thalmeier wrote:
> On Thu, May 18, 2017 at 05:56:31PM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 18/05/2017 at 16:45:21 +0200, Michael Thalmeier wrote:
> > > To detect when the backup power domain has lost power a software defined bit
> > > is set in one of the general purpose persistent registers when writing a new
> > > time into the rtc.
> > > When reading the time this bit is checked to determine if a power fail has
> > > happened since the last time the rtc time was set.
> > > 
> > 
> > I'm kind of concerned that other people may want to use those register
> > for something else but I don't currently have anything better to
> > suggest.
> > 
> > The other concern is that when updating the kernel, this will make amm
> > the rtc report that the time is invalid until the next update. So this
> > should be disabled by default.
> 
> How would you think this is best to disable by default? With a config
> option or with a module parameter?
> Either way would also allow to make the bit mask in the PERSISTENT2
> register configurable, so one can use whichever bit is still unused by
> some other applications.
> 

What you could do is export the persistent registers with nvmem. Then
you can define a cell in DT using a bit in persistent2 and use it from
the rtc driver itself.

If the cell is defined, then the driver know it has been configured to
detect power failure.


> > 
> > > When we detect a power fail we return -ENODATA.
> > > 
> > 
> > All the other drivers return -EINVAL in that case.
> > 
> > > Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> > > ---
> > >  drivers/rtc/rtc-stmp3xxx.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> > > index d578e40..51330ec 100644
> > > --- a/drivers/rtc/rtc-stmp3xxx.c
> > > +++ b/drivers/rtc/rtc-stmp3xxx.c
> > > @@ -62,6 +62,9 @@
> > >  /* missing bitmask in headers */
> > >  #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
> > >  
> > > +#define STMP3XXX_RTC_PERSISTENT2		0x80
> > > +#define STMP3XXX_RTC_PERSISTENT2_VALID_TIME	0x01
> > > +
> > >  struct stmp3xxx_rtc_data {
> > >  	struct rtc_device *rtc;
> > >  	void __iomem *io;
> > > @@ -160,6 +163,10 @@ static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	if (!(readl(rtc_data->io + STMP3XXX_RTC_PERSISTENT2) &
> > > +				STMP3XXX_RTC_PERSISTENT2_VALID_TIME))
> > > +		return -ENODATA;
> > > +
> > >  	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
> > >  	return 0;
> > >  }
> > > @@ -169,6 +176,8 @@ static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
> > >  	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
> > >  
> > >  	writel(t, rtc_data->io + STMP3XXX_RTC_SECONDS);
> > > +	writel(STMP3XXX_RTC_PERSISTENT2_VALID_TIME,
> > > +		rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_SET);
> > >  	return stmp3xxx_wait_time(rtc_data);
> > >  }
> > >  
> > > -- 
> > > 2.9.2
> > > 
> > 
> > -- 
> > Alexandre Belloni, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com
> 
> -- 
> 
> Michael Thalmeier
> (Entwicklung)
> HALE electronic GmbH
> Eugen-Müller-Straße 18, 5020 Salzburg, Austria
> Tel: +43 (662) 439011 0
> Fax: +43 (662) 439011 9
> michael.thalmeier@hale.at
> Firmenbuchnummer: FN 66801m HG Salzburg

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
