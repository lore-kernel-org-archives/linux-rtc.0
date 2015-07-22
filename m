Return-Path: <rtc-linux+bncBDP6N55ZUYDRBUU5YCWQKGQEXFUL6BY@googlegroups.com>
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com. [2607:f8b0:400e:c02::22e])
        by gmr-mx.google.com with ESMTPS id ys2si529171pac.0.2015.07.22.14.44.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 14:44:50 -0700 (PDT)
Received: by mail-pd0-x22e.google.com with SMTP id g1so144895171pdr.2
        for <rtc-linux@googlegroups.com>; Wed, 22 Jul 2015 14:44:50 -0700 (PDT)
Date: Wed, 22 Jul 2015 14:44:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH 4/4] RTC: switch to using is_visible() to
 control sysfs attributes
Message-ID: <20150722214446.GE14875@dtor-ws>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
 <1437433372-15425-4-git-send-email-dmitry.torokhov@gmail.com>
 <CAJKOXPevQGGwCYgcH9zJ6b9c4u=XV6pO2tzne0Ub3uinDjLqvQ@mail.gmail.com>
 <20150722205735.GP2853@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150722205735.GP2853@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jul 22, 2015 at 10:57:35PM +0200, Alexandre Belloni wrote:
> (Krzysztof, be careful, Dmitry was not in copy of your maili, you should
> probably check your mailer config)
> 
> On 21/07/2015 at 10:21:11 +0900, Krzysztof Kozlowski wrote :
> > 2015-07-21 8:02 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > >  static ssize_t
> > > -rtc_sysfs_set_wakealarm(struct device *dev, struct device_attribute *attr,
> > > +wakealarm_store(struct device *dev, struct device_attribute *attr,
> > >                 const char *buf, size_t n)
> > >  {
> > >         ssize_t retval;
> > > @@ -221,45 +209,58 @@ rtc_sysfs_set_wakealarm(struct device *dev, struct device_attribute *attr,
> > >         retval = rtc_set_alarm(rtc, &alm);
> > >         return (retval < 0) ? retval : n;
> > >  }
> > > -static DEVICE_ATTR(wakealarm, S_IRUGO | S_IWUSR,
> > > -               rtc_sysfs_show_wakealarm, rtc_sysfs_set_wakealarm);
> > > +static DEVICE_ATTR_RW(wakealarm);
> > 
> > This and renaming of show/store functions look unrelated
> > 
> 
> I don't really mind that one but I would also prefer if it could be
> separated.

OK, I will.

> 
> > >
> > > +static struct attribute *rtc_attrs[] = {
> > > +       &dev_attr_name.attr,
> > > +       &dev_attr_date.attr,
> > > +       &dev_attr_time.attr,
> > > +       &dev_attr_since_epoch.attr,
> > > +       &dev_attr_max_user_freq.attr,
> > > +       &dev_attr_hctosys.attr,
> > > +       &dev_attr_wakealarm.attr,
> > > +       NULL,
> > > +};
> > >
> > > -/* The reason to trigger an alarm with no process watching it (via sysfs)
> > > +/*
> > > + * The reason to trigger an alarm with no process watching it (via sysfs)
> > >   * is its side effect:  waking from a system state like suspend-to-RAM or
> > >   * suspend-to-disk.  So: no attribute unless that side effect is possible.
> > >   * (Userspace may disable that mechanism later.)
> > >   */
> > > -static inline int rtc_does_wakealarm(struct rtc_device *rtc)
> > > +static bool rtc_does_wakealarm(struct rtc_device *rtc)
> > >  {
> > >         if (!device_can_wakeup(rtc->dev.parent))
> > > -               return 0;
> > > +               return false;
> > > +
> > >         return rtc->ops->set_alarm != NULL;
> > >  }
> > 
> > This looks unrelated too and confuses me. Could you split such cleanup
> > from main goal of the patch?
> > 
> 
> That one is bothering me too.

Will separate this too.

Thanks.

-- 
Dmitry

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
