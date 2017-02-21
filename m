Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB47FWDCQKGQEUGLX23I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q4si1234238wma.3.2017.02.21.04.30.42
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 04:30:42 -0800 (PST)
Date: Tue, 21 Feb 2017 13:30:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean.nyekjaer@prevas.dk>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: pcf2127: bulk read only date and time registers.
Message-ID: <20170221123037.f3skrfctffs35cs5@piout.net>
References: <20170201124525.36578-1-sean.nyekjaer@prevas.dk>
 <20170211232135.7bxr4t3pyhdmidh5@piout.net>
 <8e2684bc-92bb-7f8f-f4e8-248285be4e0b@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <8e2684bc-92bb-7f8f-f4e8-248285be4e0b@prevas.dk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/02/2017 at 21:23:19 +0100, Sean Nyekj=C3=A6r wrote:
> > > -	ret =3D regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1, buf,
> > > -				sizeof(buf));
> > > +	ret =3D
> > > +	    regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1 + 3, (buf +=
 3),
> > > +			     7);
> > This is weirdly indented/wrapped. Also, you can probably make buf a
> > char[7] and continue using sizeof() or even better, ARRAY_SIZE()
> I'm fixing the indentation for v2 :-)
> I agree this is not the prettiest but i actually thinks its best to keep =
the
> buf[10],
> then all the existing defines for registeres will continue to work.
> Thats why i did this uglyness.
> I could do an timebuf[7], read the time into that and replace the registe=
r
> defines,
> with array numbers but it will create a lot more diff linies :-S
> What do you think ?

Then, what about:
 regmap_bulk_read(pcf2127->regmap, PCF2127_REG_SC, (buf + PCF2127_REG_SC), =
sizeof(buf) - PCF2127_REG_SC);


--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

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
