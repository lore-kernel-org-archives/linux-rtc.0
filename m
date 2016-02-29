Return-Path: <rtc-linux+bncBDS7HNEFSALRBROD2K3AKGQERNFF6TQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h126si444777wme.0.2016.02.29.11.53.40
        for <rtc-linux@googlegroups.com>;
        Mon, 29 Feb 2016 11:53:40 -0800 (PST)
Date: Mon, 29 Feb 2016 20:52:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160229195258.GB2627@piout.net>
References: <20160227153918.3c3d3853@wiggum>
 <20160228003139.GB2398@piout.net>
 <20160228094452.132c1938@wiggum>
 <20160228104110.GC2398@piout.net>
 <20160228125852.1a0b271e@wiggum>
 <20160228123618.GD2398@piout.net>
 <20160228181450.3ba14f7f@wiggum>
 <20160228213920.GA2260@piout.net>
 <20160229180749.42f75ec8@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160229180749.42f75ec8@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/02/2016 at 18:07:49 +0100, Michael B=C3=BCsch wrote :
> > Also, to export the temperature, use hwmon, see:
> > http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?=
h=3Drtc-next&id=3D445c02076f1e60d2ee51503bf1288ef9f3bc8809
>=20
> That is a rather weird API.
> Is there a special naming scheme required for the attribute?
> What does the 'input' mean in 'temp1_input'? And why is it temp1
> instead of temp0?

It means that you can read the value as opposed to output it for example
on a 3d printing nozzle.

I'm not sure why it is indexed starting with 1 but probably because
usually that's how user documentation is written. You'd have to ask the
hwmon maintainers ;)

>=20
> > You may want to use regmap instead of defining your own update_bits
> > (rv3029c2_i2c_maskset_reg) but that is a more invasie change that you
> > may leave out for now.
>=20
> Ok, I will do this last.
> Don't hold your breath. :)
>=20

I'm not even sure this is a good idea but I'd need to have a look at the
code to know ;)


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
