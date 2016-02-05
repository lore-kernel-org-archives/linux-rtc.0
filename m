Return-Path: <rtc-linux+bncBDS7HNEFSALRBDPI2K2QKGQEUKVZMFY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s132si1030747wmd.1.2016.02.05.06.39.09
        for <rtc-linux@googlegroups.com>;
        Fri, 05 Feb 2016 06:39:09 -0800 (PST)
Date: Fri, 5 Feb 2016 15:39:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 1/3] rtc: Add functions to set and read rtc offset
Message-ID: <20160205143908.GJ4782@piout.net>
References: <20160202104111.GU20165@piout.net>
 <1454519804-13770-1-git-send-email-stillcompiling@gmail.com>
 <20160204220754.GB4782@piout.net>
 <20160204153242.566a5a1f@jclayton-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160204153242.566a5a1f@jclayton-pc>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/02/2016 at 15:32:42 -0800, Joshua Clayton wrote :
> > > +int rtc_read_offset(struct rtc_device *rtc, long *offset)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (!rtc->ops)
> > > +		return -ENODEV;
> > > +
> > > +	if (!rtc->ops->set_offset) {
> > > +		*offset = 0;
> > > +		return 0;
> > > +	}
> > > +
> > 
> > I should have been clearer but this is not necessary anymore since the
> > sysfs interface will not always be present but you
> > should probably test rtc->ops->read_offset instead.
> >
> I left it because the kernel API is still there even if the sysfs
> file is not...
> but yeah, you are right. I'll fix the check, and the formatting
> in the other patch.
> 

Yeah but from inside the kernel, I feel that it is more useful to know
that the value doesn't exist instead of having 0.


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
