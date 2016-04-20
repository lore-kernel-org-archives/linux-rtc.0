Return-Path: <rtc-linux+bncBDP47C6LHEINZLW6XACRUBD5TNA54@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from pokefinder.org (sauhun.de. [89.238.76.85])
        by gmr-mx.google.com with ESMTPS id a136si730485wma.0.2016.04.20.07.51.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 07:51:07 -0700 (PDT)
Date: Wed, 20 Apr 2016 16:51:04 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	johnstul@us.ibm.com
Subject: [rtc-linux] Re: [1/3] rtc: mc13xxx: remove UIE signaling
Message-ID: <20160420145104.GB1551@katana>
References: <1304523088-17039-2-git-send-email-w.sang@pengutronix.de>
 <20160420143751.GT29844@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
In-Reply-To: <20160420143751.GT29844@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Apr 20, 2016 at 04:37:51PM +0200, Alexandre Belloni wrote:
> On 04/05/2011 at 17:31:26 +0200, Wolfram Sang wrote :
> > The RTC core handles it since 6610e08 (RTC: Rework RTC code to use
> > timerqueue for events). So far, only the callbacks to the RTC core have
> > been removed, but not the handlers. Do this now.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> >  drivers/rtc/rtc-mc13xxx.c |   23 -----------------------
> >  1 files changed, 0 insertions(+), 23 deletions(-)
> > 
> 
> Almost five years ago, you sent that patch...

Wow, I almost forgot about it ;)))

Thanks for picking it up.

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

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXF5dYAAoJEBQN5MwUoCm2PGAQALZok5nFRlelQeC4yr+h4VGu
Ixt4qsFTykctOmTCFsX6McOfiDyX6wMIxpa5xPUr5HmKGX2vkJsvWcHZPiorr7pw
HU0FVnOMSm++3bBbMifJrZA7Zif7kHQ2idNOhvVlaS36kw/y+vLGrmby1vMYbavX
yzwNrLCkbAaP2OjrVlHXPjFHh13OE2+10GRKJ50U3B1r5K40EhuQ/0JP3ZTMZVxT
mHcvheem37f9lW4nLo86W6WoWwku0yJIQIJ1pTZjrnNlYFnMGEGqZRkqTBC2XVRw
vwsJAZqMmQjBs6d68Y6mh0e3ocvCit9HHF4FFzz48PcM2fnrXVqY7UJuiXKvXeLp
rE5iAgf0IiOVueXeHi4ZTgpOh7URmfWXwTHIWaaL8X/XV3D88FtwydaXBFlKTK+1
QsdMhuRxwajoItDsCXHnQBUlCHmnWY/bzU8qzHf1c/zWGDeorvaRgUA4Hi4yplIf
XkIeOWMfROjBKIAUiiE9hKKa5nCu4qvxr5cP8Fif7FsIWR3I+Z6iAQvVabsRSbsp
BUrDofeOtC8C5rgSp85Z4D5bbocs2LkJVzt5Y57MCV96Ye6GrXFZWT/0FOXS5A+i
U/dXzwuT1NlUuLG5JagAxi7IBarL3rtuPCHOY9LIgb0OQVp/K9dgcfYR9XGFiTbv
YfIovGAB/Uq/y3tSiG4f
=lqbF
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
