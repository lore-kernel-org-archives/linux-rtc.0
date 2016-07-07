Return-Path: <rtc-linux+bncBDSJBYGBRIMBBTPT665QKGQESHLM54Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c135si225575wme.2.2016.07.06.23.42.21
        for <rtc-linux@googlegroups.com>;
        Wed, 06 Jul 2016 23:42:21 -0700 (PDT)
Date: Thu, 7 Jul 2016 08:42:20 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Stephan Roslen <stephan@roslen.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: sunxi: use external oscillator
Message-ID: <20160707064220.GA5907@lukather>
References: <577CC494.8020103@roslen.de>
 <20160706202000.GC4247@lukather>
 <577DDF8C.6060404@roslen.de>
 <CAGb2v64Q6ERA2cHP48Wop5hdmKq0aYSUDfU6Q7qDGRJmk5G--g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
In-Reply-To: <CAGb2v64Q6ERA2cHP48Wop5hdmKq0aYSUDfU6Q7qDGRJmk5G--g@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Jul 07, 2016 at 12:53:29PM +0800, Chen-Yu Tsai wrote:
> >> In order to have that correctly propagated, you should register a new
> >> mux here in the clock framework, and have all the other clocks using
> >> that mux as a parent.
> >
> > I agree. Checking the diagram in subsection 1.5.2 of the A20
> > manual it seems, that LOSC can be a source for clocks like CPU and
> > some SoC busses. So my patch could indeed mess with the whole
> > clock tree.
> 
> Within the current sunxi clk structure, the LOSC is registered as a fixed
> 32.768 KHz clk. So this patch actually makes things right.

On the condition that the driver gets loaded, which is not guaranteed.

Maxime

-- 
Maxime Ripard, Free Electrons
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

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXffnMAAoJEBx+YmzsjxAgx1gP/3CQ5C8YfMMm/tnyB+vzK+ex
ntPbIt5CvhkqkXj+omYoK3R3j5CE/tXMxI4As49u1t7Z0jHWeIv5vjK6ojBoRSaP
/JX9OL0Gjq/HYptPOvsxYNezmAu4XDrgFpCfcZNZghGfHANaSQVr5kYIF6b1Z05w
ccTKIMJYf037sWH5brx1jrLNiQVt5Z9Avf0yKei/AoS3qSqCxF8KGseG3JyA7g8f
wz682qoo23xkLFHSQVrXefxqbSXHZs3HVADQMqX1urJyXynHigYDghO+qsQB+GbX
o+4eupUQbyaC5G1LjSV8TR5hmFE0uA3N88Is0Csw7IT0+RMJFlnKFX/xpjmwqNkS
HIZ//STLj3N4Eie6N5Es1pBz0zAzH12FMSPFJ1UhgGH7iZXNG+clCRtZeZQEAaQg
DZaZ/iDGN7mlry5sn34EzbFGUfJsCJy9nnomt6TY5c6aC4Y1+2rubuXZLQgBDaOo
joAJMAocTq/i6NaiW0lWTpXwfWnoFZPbFw2UKmC4Psq3Wf6SLPsD9IUxa9TUqudp
Qk6t0P4yQana7dx/0bZ4BytP9L5CpkiPq0GAnfCfi4dmorz3XIq1MRbekg7KfSlE
AZkzMfNC28aRkOOwmzGcR4hjAHZCo/MnqsysibagOabhfICIU9bSwlYgr8YobAOO
KAlNOGa83oxenHFE7+K9
=df2i
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
