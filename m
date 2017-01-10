Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB76W2DBQKGQECZV3NWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 133si762902wmj.1.2017.01.09.16.31.59
        for <rtc-linux@googlegroups.com>;
        Mon, 09 Jan 2017 16:31:59 -0800 (PST)
Date: Tue, 10 Jan 2017 01:31:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <vesa.jaaskelainen@vaisala.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 2/2] drivers: rtc: rtc-tps65910: use
 'unsigned int' instead of 'unsigned' in arguments
Message-ID: <20170110003158.4vzhbknrxbr5fmb7@piout.net>
References: <1482491759-39335-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1482491759-39335-3-git-send-email-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1482491759-39335-3-git-send-email-vesa.jaaskelainen@vaisala.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/12/2016 at 13:15:59 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
> Fixes checkpatch.pl warning:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>=20
> Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisal=
a.com>
> ---
>  drivers/rtc/rtc-tps65910.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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
