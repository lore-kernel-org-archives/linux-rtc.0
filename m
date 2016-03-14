Return-Path: <rtc-linux+bncBDS7HNEFSALRB5VUTO3QKGQETYNE7KI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c7si532710wmf.2.2016.03.14.08.36.21
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 08:36:21 -0700 (PDT)
Date: Mon, 14 Mar 2016 16:36:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: rv3029: Add update_bits helper for
 eeprom access
Message-ID: <20160314153618.GC2693@piout.net>
References: <20160310183346.73aa0f24@wiggum>
 <20160310183423.12a02e1f@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160310183423.12a02e1f@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/03/2016 at 18:34:23 +0100, Michael B=C3=BCsch wrote :
> This simplifies the update of single bits in the eeprom.
>=20
> Signed-off-by: Michael Buesch <m@bues.ch>
> ---
>  drivers/rtc/rtc-rv3029c2.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
Applied, thanks.

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
