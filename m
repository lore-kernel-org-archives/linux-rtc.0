Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56587 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0SBp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 27 Jun 2017 14:01:45 -0400
Date: Tue, 27 Jun 2017 20:01:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Kirill Esipov <yesipov@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rtc: ds3232: add temperature support
Message-ID: <20170627180143.cafxe6bvyblywuba@piout.net>
References: <1498150704-21777-1-git-send-email-yesipov@gmail.com>
 <CAHp75Vd-CoKpt0dhXspCDLSoohEVRTHEEPn9jZtFqUwvAeB1bA@mail.gmail.com>
 <CAJcpCzF1SJ2v-KsJXN7c=BogeQv4LdAZEgZFsgVVy3HKPCcO1Q@mail.gmail.com>
 <20170627130057.yhhalp2epmmdicz7@piout.net>
 <CAJcpCzEHW8GSkykidpq=GBo-aFbFstmOmQZhAYu-NWBWxTc=uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJcpCzEHW8GSkykidpq=GBo-aFbFstmOmQZhAYu-NWBWxTc=uA@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 27/06/2017 at 18:27:42 +0300, Kirill Esipov wrote:
> 2017-06-27 16:00 GMT+03:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
> > On 27/06/2017 at 15:24:57 +0300, Kirill Esipov wrote:
> >> 2017-06-25 19:39 GMT+03:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> >> > On Thu, Jun 22, 2017 at 7:58 PM, Kirill Esipov <yesipov@gmail.com> wrote:
> >> >> DS3232/DS3234 has the temperature registers with a resolution of 0.25
> >> >> degree celsius. This enables to get the value through hwmon.
> >> >>
> >> >>         # cat /sys/class/hwmon/hwmon0/temp1_input
> >> >>         37250
> >> >
> >> >> +config RTC_DRV_DS3232_HWMON
> >> >> +       bool "HWMON support for Dallas/Maxim DS3232/DS3234"
> >> >
> >> >> +       depends on RTC_DRV_DS3232 && HWMON
> >> >> +       depends on !(RTC_DRV_DS3232=y && HWMON=m)
> >> >
> >> > Perhaps it might be squeezed into one line (something like that logic
> >> > has been required by I2C related PMIC IIRC)
> >> >
> >> >> +       default y
> >> >
> >> > Is it really sane default?
> >> >
> >>
> >> At first sight i thought that yes it is sane default (and others RTC with
> >> hwmon set it "default y" (ds1307, rv3029c2)).
> >> But if it's not sane, then we should turn it off by default in others drivers?
> >>
> >
> > It is definitively sane.
> >
> >>
> >> >> +#ifdef CONFIG_RTC_DRV_DS3232_HWMON
> >> >
> >> > IS_BUILTIN() ?
> >> >
> >
> > I'd use IS_ENABLED in that case.
> >
> 
> Why? "RTC_DRV_DS3232_HWMON" is bool, not tristate. So it can't be
> defined as "m".
> 

It's clearer and doesn't hurt but really, #ifdef
CONFIG_RTC_DRV_DS3232_HWMON is just fine.

> >> >> +static int ds3232_hwmon_read_temp(struct device *dev, long int *mC)
> >> >> +{
> >> >> +       struct ds3232 *ds3232 = dev_get_drvdata(dev);
> >> >> +       u8 temp_buf[2];
> >> >> +       s16 temp;
> >> >> +       int ret;
> >> >> +
> >> >> +       ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_TEMPERATURE, temp_buf,
> >> >> +                               sizeof(temp_buf));
> >> >
> >> >> +
> >> >
> >> > Remove.
> >
> > I'd recommend running checkpatch.pl --strict to remove the remaining
> > whitespace issues too (a few alignments are off).
> >
> >> >
> >> > I dunno which style is preferred, though you may use
> >> > if (IS_BUILTIN(...))
> >> >  return;
> >> >
> >> > at the beginning of the function and allow gcc optimizer to take care
> >> > of everything else.
> >> >
> >
> > I don't have a strong opinion there.
> >
> > --
> > Alexandre Belloni, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com
> 
> 
> 
> -- 
> Kirill Esipov

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
