Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB36W2DBQKGQERGLCGZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id o77si1044174wme.0.2017.01.09.16.31.43
        for <rtc-linux@googlegroups.com>;
        Mon, 09 Jan 2017 16:31:43 -0800 (PST)
Date: Tue, 10 Jan 2017 01:31:43 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <vesa.jaaskelainen@vaisala.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Message-ID: <20170110003143.kmd3fvk5cumq6x4c@piout.net>
References: <1482491759-39335-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1482491759-39335-2-git-send-email-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1482491759-39335-2-git-send-email-vesa.jaaskelainen@vaisala.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/12/2016 at 13:15:58 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
> Texas Instrument's TPS65910 has support for compensating RTC crystal
> inaccuracies. When enabled every hour RTC counter value will be compensat=
ed
> with two's complement value.
>=20
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisal=
a.com>
> ---
> Changes in v3:
>   - Changed to return 0 from offset when auto compensation is not enabled
>=20
> Changes in v2:
>   - Changed to use offset interface
>=20
>  drivers/rtc/rtc-tps65910.c   | 143 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/tps65910.h |   1 +
>  2 files changed, 144 insertions(+)
>=20
Applied, thanks.

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
