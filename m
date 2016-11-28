Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBU6257AQKGQERJ5LNEI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 85si2334569wmb.3.2016.11.28.00.39.46
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Nov 2016 00:39:46 -0800 (PST)
Date: Mon, 28 Nov 2016 09:39:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-ds3232: add device tree support
Message-ID: <20161128083941.zrwlai3ydhyrc6br@piout.net>
References: <20161128070644.8386-1-pbrobinson@gmail.com>
 <20161128082407.brdt5qivibf32uk2@piout.net>
 <CALeDE9Ojf9d2bFHndyfzs897a4rrqx9XiH7EHEvwCOGx1kpwmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CALeDE9Ojf9d2bFHndyfzs897a4rrqx9XiH7EHEvwCOGx1kpwmg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/11/2016 at 08:31:20 +0000, Peter Robinson wrote :
> On Mon, Nov 28, 2016 at 8:24 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Hi,
> >
> > On 28/11/2016 at 07:06:44 +0000, Peter Robinson wrote :
> >> Set the of_match_table for this driver so that devices can be described in
> >> the device tree.  This device is used in a number of NXP devices as well as
> >> the CryptoCap and is already defined in the various device trees.
> >>
> >
> > This is useless (as you mention it is already used in various device
> > trees) as it will already be probed properly using the "dallas,ds3232"
> > compatible string.
> 
> Why? The driver doesn't currently set the compatible string.
> 

The i2c core does that for you using the i2c_device_id array.

> >> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> >> ---
> >>  drivers/rtc/rtc-ds3232.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> >> index b1f20d8..711cc5b 100644
> >> --- a/drivers/rtc/rtc-ds3232.c
> >> +++ b/drivers/rtc/rtc-ds3232.c
> >> @@ -15,6 +15,7 @@
> >>
> >>  #include <linux/kernel.h>
> >>  #include <linux/module.h>
> >> +#include <linux/of.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/i2c.h>
> >>  #include <linux/spi/spi.h>
> >> @@ -438,9 +439,18 @@ static const struct i2c_device_id ds3232_id[] = {
> >>  };
> >>  MODULE_DEVICE_TABLE(i2c, ds3232_id);
> >>
> >> +#ifdef CONFIG_OF
> >> +static const struct of_device_id ds3232_of_match[] = {
> >> +     { .compatible = "dallas,ds3232", },
> >> +     { }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, ds3232_of_match);
> >> +#endif
> >> +
> >>  static struct i2c_driver ds3232_driver = {
> >>       .driver = {
> >>               .name = "rtc-ds3232",
> >> +             .of_match_table = of_match_ptr(ds3232_of_match),
> >>               .pm     = &ds3232_pm_ops,
> >>       },
> >>       .probe = ds3232_i2c_probe,
> >> --
> >> 2.9.3
> >>
> >
> > --
> > Alexandre Belloni, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
