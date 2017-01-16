Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBHUL6TBQKGQEWXYNYUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h198si702145wmg.1.2017.01.16.09.40.45
        for <rtc-linux@googlegroups.com>;
        Mon, 16 Jan 2017 09:40:45 -0800 (PST)
Date: Mon, 16 Jan 2017 18:40:43 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	stable@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: sun6i: Switch to the external oscillator
Message-ID: <20170116174043.hgqbnmdnsfbnxl3m@piout.net>
References: <20170116152148.27439-1-maxime.ripard@free-electrons.com>
 <20170116153959.7qhahevikxzai664@piout.net>
 <20170116161349.5btadrfmqbxhrb2c@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170116161349.5btadrfmqbxhrb2c@lukather>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 16/01/2017 at 17:13:49 +0100, Maxime Ripard wrote :
> On Mon, Jan 16, 2017 at 04:39:59PM +0100, Alexandre Belloni wrote:
> > On 16/01/2017 at 16:21:48 +0100, Maxime Ripard wrote :
> > > The RTC is clocked from either an internal, imprecise, oscillator or an
> > > external one, which is usually much more accurate.
> > > 
> > > The difference perceived between the time elapsed and the time reported by
> > > the RTC is in a 10% scale, which prevents the RTC from being useful at all.
> > > 
> > > Fortunately, the external oscillator is reported to be mandatory in the
> > > Allwinner datasheet, so we can just switch to it.
> > > 
> > 
> > Still, I'm wondering whether the external clock should be taken.
> > 
> > We've had issues with at91 and tegra where this external clock was
> > suddenly able to be stopped, breaking the RTC because the CCF was not
> > aware the RTC was using it.
> 
> That's a very good point...
> 
> > See:
> > http://patchwork.ozlabs.org/patch/502459/
> > http://patchwork.ozlabs.org/patch/714517/
> > 
> > Your reply can be that you don't care now and this has a low probability
> > and you'll handle the case when it happens and that will be fine.
> 
> This is a bit more complicated for us.
> 
> The internal oscillator is running at 667kHz, with a 30% accuracy. The
> external oscillator is supposed to run at 32768Hz, with a maximum
> tolerance of 50ppm.
> 
> The RTC has an internal mux, between the internal and external
> oscillators. If the internal is picked, a (variable) divider of 20 is
> applied by default.
> 
> The output of that mux is also one of the parent of many of our clocks
> in our main clock unit (for example the CPU one), so we need to have
> that parenthood relationship expressed. I guess we could rework the
> driver to first register the clock through the early clock probing
> stuff, and then have the rest of the RTC to probe.
> 
> However, we also need to do so while remaining backward compatible
> from a DT point of view.
> 
> I guess we could:
>   - Add the two oscillators to the DTSI, with their proper accuracy
>   - Put them both as parent clocks of the RTC node
>   - Split the clock part and the RTC part in the driver, and have the
>     clock part, if there is a clocks property in the node (which
>     covers the backward case), register the mux, and pick the clock
>     with the best accuracy. We don't change anything at the RTC level.
>   - Change the parent clock of the CCU for the RTC.
> 
> That would work for you?

That would definitively be better. If the 667kHz oscillator is not an
input to any other IP, you may as well register it directly from the
driver instead of representing it as a node.

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
