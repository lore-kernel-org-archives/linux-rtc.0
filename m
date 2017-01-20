Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBJO4RDCAKGQEO7S5JMQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 133si216544wmj.1.2017.01.20.07.35.00
        for <rtc-linux@googlegroups.com>;
        Fri, 20 Jan 2017 07:35:00 -0800 (PST)
Date: Fri, 20 Jan 2017 16:34:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>, b20788@freescale.com,
	shawnguo@kernel.org, Frank.Li@freescale.com, kernel@pengutronix.de,
	fabio.estevam@nxp.com, a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-pm@vger.kernel.org
Subject: [rtc-linux] Re: imx6ul: power-up using the RTC
Message-ID: <20170120153459.tewyg54dcgqnpz2j@piout.net>
References: <b516070d-6539-98d1-c832-d79ac89e8d43@mobi-wize.com>
 <20170120121210.gm3wcg4yyvrigpn3@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170120121210.gm3wcg4yyvrigpn3@earth>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/01/2017 at 13:12:10 +0100, Sebastian Reichel wrote :
> Hi,
> 
> On Wed, Jan 18, 2017 at 04:49:11PM +0200, Guy Shapiro wrote:
> > I'm trying to use the low power RTC of the i.MX6UL to start from
> > power-off state.
> > 
> > I started by hopefully running: # echo +30 >
> > /sys/class/rtc/rtc0/wakealarm && shutdown -h now The system was
> > powered down, but it didn't come up after 30 seconds as expected.
> > 
> > So I dug into the datasheet and the source...
> > To activate the power on alarm, the flags SRTC_ENV, LPTA_EN and LPWUI_EN on
> > the SNVS_LP Control register (LPCR) should be asserted. The wakeup time
> > should be written to the SNVS_LP Time alarm register (LPTA). The code that
> > does this is on drivers/rtc/rtc-snvs.c:snvs_rtc_set_alarm().
> > 
> > The first problem I found was with the use of the syscon-poweroff driver.
> > The "Turn off System Power" flag is part of the same register (LPCR). The
> > current code of syscon-poweroff set the register to the "mask" property from
> > the device tree on power off, overriding all the existing flags.
> > After setting the "mask" property on the device tree to 0x6b instead of
> > 0x60 (asserting the mentioned bits), the system do power up on timer, as
> > expected.
> > 
> > However, I didn't like the idea of keeping those flags on even when no one
> > set the alarm.
> > As a quick test, I modified the syscon-poweroff driver to ignore the bits
> > that are not on the mask:
> > 
> > diff --git a/drivers/power/reset/syscon-poweroff.c
> > b/drivers/power/reset/syscon-poweroff.c
> > index b683383..a5da02b 100644
> > --- a/drivers/power/reset/syscon-poweroff.c
> > +++ b/drivers/power/reset/syscon-poweroff.c
> > @@ -33,7 +33,7 @@ static u32 mask;
> > static void syscon_poweroff(void)
> > {
> >         /* Issue the poweroff */
> > -       regmap_write(map, offset, mask);
> > +       regmap_update_bits(map, offset, mask, mask);
> >         mdelay(1000);
> > 
> > 
> > After applying this fix, the wake up alarm didn't work. Strangely, when I
> > added some debug prints to investigate the case, it worked again
> > (sometimes... depends on the exact places I add the prints).
> > I suspect that some other driver clears the flags during the power down, but
> > I couldn't find such driver.
> > 
> > Do you have any clue what code may change this register during the shutdown
> > process? Any other insights are welcomed as well :)
> 
> To summarize it looks like this?
> 
> | regmap_write       | 0x60 | broken                     |
> | regmap_write       | 0x6b | works stable               |
> | regmap_update_bits | 0x60 | works only with dbg prints |
> 
> For me it looks like the debug prints may delay the poweroff driver
> long enough, that some other driver (rtc?) writes the 0x0b bits.
> 

Is snvs_rtc_alarm_irq_enable() waiting long enough? I'd say yes but you
never know... You can also use the kernel tracin infrastructure to trace
every accesses made to that regmap. That could give you a hint.

At least you can try a regmap_read before returning from
snvs_rtc_alarm_irq_enable() and see whether SNVS_LPCR_LPTA_EN and
SNVS_LPCR_LPWUI_EN are still there.



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
