Return-Path: <rtc-linux+bncBCUYRNXYZECRBEUG6SVAKGQEBDFK33Q@googlegroups.com>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id k2si202357wif.0.2015.05.20.14.56.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 14:56:31 -0700 (PDT)
Date: Wed, 20 May 2015 22:56:15 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Zhi Li <lznuaa@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"Frank.Li@freescale.com" <Frank.Li@freescale.com>,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	alexandre.belloni@free-electrons.com,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-input@vger.kernel.org,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
Message-ID: <20150520215615.GZ2067@n2100.arm.linux.org.uk>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520015851.GB1071@dragon>
 <20150520182540.GQ2067@n2100.arm.linux.org.uk>
 <20150520183050.GR2067@n2100.arm.linux.org.uk>
 <CAHrpEqSngMgOj5Bjp0XWpw9CJCjoiU63iRuAX3Zw_aEO+-5RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAHrpEqSngMgOj5Bjp0XWpw9CJCjoiU63iRuAX3Zw_aEO+-5RHg@mail.gmail.com>
Sender: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, May 20, 2015 at 01:44:58PM -0500, Zhi Li wrote:
> On Wed, May 20, 2015 at 1:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Looking at the RTC code, it would be pretty trivial to do.
> >
> > Rather than passing around struct regmap, pass around the private data
> > structure.
> >
> > Rename the regmap_* function calls to be private accessors.  Implement
> > a set of new accessors - if the private data has the regmap, use the
> > regmap API.  Otherwise, use the old method, and print a warning that an
> > old DT is being used.
> 
> This method work.  But code will become ugly and complex. I seach
> whole dts tree.
> Only imx6 use this driver.
> 
> Does it really valuable to keep compatiblity with cost of complex driver code?

Let me put this a different way.

Would you be upset if you installed a new kernel, rebooted and found that
the system then fscked your filesystem, stamping a date of 1 Jan 1970
on it.  Then you use a later dtb, and you have to go through another
fsck of your filesystem because it's apparently been more than "31 days"
or so since it was last fscked, and all this caused by the RTC vanishing
because we couldn't be bothered with backward compatibility?

There are real products out there which use iMX6 today.  In production,
being sold.

Do not break existing DTBs unless there really is no other choice.

And I don't think it makes the code ugly, though it does make it _slightly_
more complex.  That's a price worth paying for keeping stuff working.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

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
