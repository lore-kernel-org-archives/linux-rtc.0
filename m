Return-Path: <rtc-linux+bncBCHOPY7NVYCRBXHD6SVAKGQETAWOVBY@googlegroups.com>
Received: from mail-ob0-x234.google.com (mail-ob0-x234.google.com. [2607:f8b0:4003:c01::234])
        by gmr-mx.google.com with ESMTPS id x1si14749igb.2.2015.05.20.18.16.12
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 18:16:12 -0700 (PDT)
Received: by obcus9 with SMTP id us9so49883027obc.2
        for <rtc-linux@googlegroups.com>; Wed, 20 May 2015 18:16:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150521002043.GI23809@dtor-ws>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
	<20150520015851.GB1071@dragon>
	<20150520182540.GQ2067@n2100.arm.linux.org.uk>
	<20150520183050.GR2067@n2100.arm.linux.org.uk>
	<20150521002043.GI23809@dtor-ws>
Date: Wed, 20 May 2015 20:16:11 -0500
Message-ID: <CAHrpEqT0cjujJzr9KD7qhS7F2fZaAhuct4Q8YHYFe0uvaR9_qw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
From: Zhi Li <lznuaa@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	alexandre.belloni@free-electrons.com, Philipp Zabel <p.zabel@pengutronix.de>,
	linux-input@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, May 20, 2015 at 7:20 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, May 20, 2015 at 07:30:50PM +0100, Russell King - ARM Linux wrote:
>> On Wed, May 20, 2015 at 07:25:41PM +0100, Russell King - ARM Linux wrote:
>> > On Wed, May 20, 2015 at 09:58:51AM +0800, Shawn Guo wrote:
>> > > On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li@freescale.com wrote:
>> > > > Frank Li (6):
>> > > >   arm: imx: power-off: change to syscon to access register
>> > > >   rtc: arm: imx: snvs: change use syscon to access register
>> > > >   Document: dt: fsl: snvs: change support syscon
>> > > >   arm: dts: imx: update snvs to use syscon access register
>> > > >   document: devicetree: input: imx: i.mx snvs power device tree bindings
>> > > >   arm: dts: imx6sx: enable snvs power key
>> > >
>> > > So, the series will break existing DTBs for RTC and poweroff, right?
>> > > If this is unavoidable, should we at least have some warning messages
>> > > telling users about his breakage?
>> >
>> > What's the justification for breaking existing DTBs?  Really, this is
>> > something we should strive to avoid, _and_ actually avoid by providing
>> > backwards compatibility.
>>
>> Looking at the RTC code, it would be pretty trivial to do.
>>
>> Rather than passing around struct regmap, pass around the private data
>> structure.
>>
>> Rename the regmap_* function calls to be private accessors.  Implement
>> a set of new accessors - if the private data has the regmap, use the
>> regmap API.  Otherwise, use the old method, and print a warning that an
>> old DT is being used.
>
> Or maybe have drivers create regmap themselves if they see old DTS and
> not bother with the 2 sets of accessors?

Does any dt node convert to regmap regardless if there are "syscon"
compatible string?

>
> Thanks.
>
> --
> Dmitry

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
