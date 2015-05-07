Return-Path: <rtc-linux+bncBAABBSHNV2VAKGQEUM2VM4Y@googlegroups.com>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.161])
        by gmr-mx.google.com with ESMTPS id g5si321130wix.1.2015.05.07.12.02.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 May 2015 12:02:31 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] RE: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Thu, 7 May 2015 19:02:29 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B223DE8@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
 <20150506160227.GA28101@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21925B@SW-EX-MBX02.diasemi.com>
 <20150506200631.GA25846@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B221DD2@SW-EX-MBX02.diasemi.com>
 <20150507175747.GB30372@roeck-us.net>
In-Reply-To: <20150507175747.GB30372@roeck-us.net>
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

On 07 May 2015 18:58 Guenter Roeck wrote:

Hi Guenter,

> > +static void da9062_apply_window_protection(struct da9062_watchdog *wdt)
> > +{
> > +       unsigned long delay = msecs_to_jiffies(DA9062_RESET_PROTECTION_MS);
> > +       unsigned long timeout = wdt->j_time_stamp + delay;
> > +       unsigned long now = jiffies;
> > +       unsigned int diff_ms;
> > +
> > +       /* if time-limit has not elapsed then wait for remainder */
> > +       if (time_before(now, timeout)) {
> > +               diff_ms = jiffies_to_msecs(timeout-now);
> > +               dev_dbg(wdt->hw->dev,
> > +                       "Delaying watchdog ping by %u msecs\n", diff_ms);
>
> I would not bother about the dev_dbg, but that is your call.
> 

.. easily removed ... I only have it in because I am worried about the case when the
watchdog gets kicked too often & quickly. If it is okay, I will leave that in because the
edge-case should be made known somewhere. Perhaps I will make it a better
debug description like "Watchdog kicked too quickly. Delaying %d ms"

> > +               mdelay(diff_ms);
>
> Can you use usleep_range() ?
> 

I put mdelay() ?? I meant to put msleep(). That's probably what I need to do now.

I did take a look at usleep_range() as I trawled for the best delay call, but usleep_range()
requires a lower and upper bound and I only have a lower bound in my case -- also, the
kernel docs "Documentation/timers/timers-howto.txt" suggest:

	SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
		* Use usleep_range
	SLEEPING FOR LARGER MSECS ( 10ms+ )
		* Use msleep [...]

I guess the majority of the time there would be zero delay-time and the code branch
wouldn't be triggered anyway, but when it is triggered the time can be anything up to
300 msecs. So I was intending to use msleep().

> Othewise looks good. BTW, I had to do something similar in
> drivers/hwmon/pmbus/zl6100.c; this is where the idea comes from.

Ah, I see, thanks.

Regards,
Steve

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
