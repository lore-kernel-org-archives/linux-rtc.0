Return-Path: <rtc-linux+bncBDS7HNEFSALRBCFVTO3QKGQE5XH4DTI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a126si442282wmd.2.2016.03.14.08.36.40
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 08:36:40 -0700 (PDT)
Date: Mon, 14 Mar 2016 16:36:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: rv3029: Add thermometer hwmon support
Message-ID: <20160314153637.GD2693@piout.net>
References: <20160310183346.73aa0f24@wiggum>
 <20160310183446.073c4b0e@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160310183446.073c4b0e@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/03/2016 at 18:34:46 +0100, Michael B=C3=BCsch wrote :
> This adds support to
> - enable/disable the thermometer
> - set the temperature scanning interval
> - read the current temperature that is used for temp compensation.
> via hwmon interface
>=20
> Signed-off-by: Michael Buesch <m@bues.ch>
> ---
>  drivers/rtc/Kconfig        |   9 ++++
>  drivers/rtc/rtc-rv3029c2.c | 120 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 129 insertions(+)
>=20
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
