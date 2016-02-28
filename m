Return-Path: <rtc-linux+bncBDS7HNEFSALRB3H7ZC3AKGQESQLAAFA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h126si249537wme.0.2016.02.27.16.31.39
        for <rtc-linux@googlegroups.com>;
        Sat, 27 Feb 2016 16:31:39 -0800 (PST)
Date: Sun, 28 Feb 2016 01:31:39 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160228003139.GB2398@piout.net>
References: <20160227153918.3c3d3853@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160227153918.3c3d3853@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 27/02/2016 at 15:39:18 +0100, Michael B=C3=BCsch wrote :
> I'm currently trying to use the Linux RV3029 RTC driver for one of my
> applications. So far the basic functionality works fine.
> However I need a way to (initially) program the EEPROM on the RTC chip
> to enable such things as temperature compensation or the trickle
> charger.
> As of now the Linux driver does not support that though. So I'm
> wondering how we should implement that. As an initial idea I think we
> could have about some sysfs attributes for these settings. Is there a
> better way (more standard API) to do this?
> If not, I'll do an implementation of this based on sysfs attributes.
>=20

trickle charging is usually enabled using device tree, however, I'd
really like to see more standardization on the property names.

I'm not sure yet about the temperature compensation. I've just merged
the crystal offset modification api with a sysfs interface in rtc-next:
http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?h=3D=
rtc-next&id=3D5f23807caab7801c3333c68417bb13c7e2439193

But this doesn't seem enough for that particular RTC.


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
