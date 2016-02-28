Return-Path: <rtc-linux+bncBDS7HNEFSALRBE6SZW3AKGQEC4RE24A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h73si371810wme.0.2016.02.28.13.39.30
        for <rtc-linux@googlegroups.com>;
        Sun, 28 Feb 2016 13:39:30 -0800 (PST)
Date: Sun, 28 Feb 2016 22:39:20 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160228213920.GA2260@piout.net>
References: <20160227153918.3c3d3853@wiggum>
 <20160228003139.GB2398@piout.net>
 <20160228094452.132c1938@wiggum>
 <20160228104110.GC2398@piout.net>
 <20160228125852.1a0b271e@wiggum>
 <20160228123618.GD2398@piout.net>
 <20160228181450.3ba14f7f@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160228181450.3ba14f7f@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/02/2016 at 18:14:50 +0100, Michael B=C3=BCsch wrote :
> On Sun, 28 Feb 2016 13:36:18 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>=20
> > More simply, don't enable the trickle charger if the
> > trickle-resistor-ohms property is missing.
> >=20
> > Leave out the trickle-diode-disable property
>=20
> D'oh indeed. :)
>=20
> The rv3029 has a clkout pin that can be configured to various
> frequencies. So I added a 'clkout-hz' property for this.
>=20

No, you have to use the CCF for that. For a recent example, see:
http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?h=3D=
rtc-next&id=3D578bb1d82bdd7fb86d5988fb775c871521a2761f

> > That part is not HW related, it should not be in the device tree. I'd
> > really just enable the temperature compensation else, this has to be
> > done in sysfs
>=20
> Ok.
>=20
> Just for the record:
> I started an initial implementation of this here in the rv3029 branch:
> git://git.bues.ch/linux.git
> http://bues.ch/gitweb?p=3Dlinux.git;a=3Dshortlog;h=3Drefs/heads/rv3029

I had a really quick look, I'll review when you post patches. Please
separate each functionality when submitting and use checkpatch.pl --strict

Also, to export the temperature, use hwmon, see:
http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?h=3D=
rtc-next&id=3D445c02076f1e60d2ee51503bf1288ef9f3bc8809

You may want to use regmap instead of defining your own update_bits
(rv3029c2_i2c_maskset_reg) but that is a more invasie change that you
may leave out for now.
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
