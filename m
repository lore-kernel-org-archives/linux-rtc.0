Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSMKSPCAKGQEFJR4NFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d130si549525wmf.0.2017.01.22.06.44.24
        for <rtc-linux@googlegroups.com>;
        Sun, 22 Jan 2017 06:44:24 -0800 (PST)
Date: Sun, 22 Jan 2017 15:44:14 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	rtc-linux@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 4/6] rtc: sun6i: Force the mux to the external oscillator
Message-ID: <20170122144414.fvir5la7cgocxfqn@piout.net>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
 <409c56f0ed1c4b0026ad60cb1218c99fe1686408.1484927680.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v650f-4RZ6RrRBGcmPz8mJ4KbJwTTj6=w3HeSWUZtLAKcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAGb2v650f-4RZ6RrRBGcmPz8mJ4KbJwTTj6=w3HeSWUZtLAKcw@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/01/2017 at 11:53:08 +0800, Chen-Yu Tsai wrote :
> Hi,
> 
> On Fri, Jan 20, 2017 at 11:56 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The internal oscillator is way too inaccurate to do something useful with
> > it. Switch to the external oscillator if it is available.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/rtc/rtc-sun6i.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> > index edd5627da10f..1695fae24cd5 100644
> > --- a/drivers/rtc/rtc-sun6i.c
> > +++ b/drivers/rtc/rtc-sun6i.c
> > @@ -493,6 +493,7 @@ static const struct rtc_class_ops sun6i_rtc_ops = {
> >  static int sun6i_rtc_probe(struct platform_device *pdev)
> >  {
> >         struct sun6i_rtc_dev *chip = sun6i_rtc;
> > +       struct clk *parent;
> >         int ret;
> >
> >         if (!chip)
> > @@ -540,6 +541,17 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
> >         /* disable alarm wakeup */
> >         writel(0, chip->base + SUN6I_ALARM_CONFIG);
> >
> > +       parent = clk_get(&pdev->dev, NULL);
> > +       if (!IS_ERR(parent)) {
> > +               ret = clk_set_parent(chip->losc, parent);
> > +               clk_put(parent);
> > +
> > +               if (ret) {
> > +                       dev_err(&pdev->dev,
> > +                               "Failed to reparent the RTC to the external oscillator\n");
> > +                       return ret;
> > +               }
> > +       }
> 
> Following what I mentioned in patch 1, maybe it is easier to force
> the mux before the clocks are registered by writing directly to
> the registers? We could also backport the changes to stable?
> 

I'd say that the risk to break existing platforms is low enough to
backport that patch to stable.
Maxime as you are certainly the one that will handle the potential
breakage, I'll let you choose what you want to do.


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
