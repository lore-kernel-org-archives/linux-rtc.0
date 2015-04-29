Return-Path: <rtc-linux+bncBAABB777QKVAKGQEAF5QM4I@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.146])
        by gmr-mx.google.com with ESMTPS id gt9si774421wib.2.2015.04.29.04.26.55
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Apr 2015 04:26:55 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Lee Jones <lee.jones@linaro.org>, "Opensource [Steve Twiss]"
	<stwiss.opensource@diasemi.com>
CC: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "David Dajun
 Chen" <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, "Samuel
 Ortiz" <sameo@linux.intel.com>, Support Opensource
	<Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
Subject: [rtc-linux] RE: [PATCH V1 6/6] devicetree: da9062: Add bindings for
 DA9062 driver
Date: Wed, 29 Apr 2015 11:26:53 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B217AE3@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <94535acf974274822c5ac16d6427299778e11ccf.1429280614.git.stwiss.opensource@diasemi.com>
 <20150429105415.GX9169@x1>
In-Reply-To: <20150429105415.GX9169@x1>
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


On 29 April 2015 11:54 Lee Jones wrote :

> On Fri, 17 Apr 2015, S Twiss wrote:
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add device tree bindings for the DA9062 driver
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> > ---
> >
> > This patch applies against linux-next and v4.0
> >
> >  Documentation/devicetree/bindings/mfd/da9062.txt | 107
> +++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
> 
> I don't see anything groundbreaking or offensive.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

Thank you for the review and Ack.

I am in the process of updating the DA9063 OnKey driver in a different thread.
This driver is functionally similar to the DA9062 OnKey driver as was discussed in
an earlier thread from DA9063.

http://www.spinics.net/lists/linux-input/msg38137.html

Although the 63 and 62 chips have sequential numbers they are not the same,
however the OnKey driver is functionally very similar and so I am going to try and
merge the code for both drivers in the case of the OnKey.

Due to the DA9063 being currently reviewed, perhaps it would be prudent not
to add this device tree bindings for DA9062 to the kernel just yet -- the device tree
bindings could change for the OnKey in my DA9063 submission and this would affect
the DA9062 driver when I merge the two OnKey drivers.

I will put a full version history in my next patch set to describe what changes I have
made to this file so this review is not deemed a wasted effort.

Regards,
Steve

[...]


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
