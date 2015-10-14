Return-Path: <rtc-linux+bncBDS7HNEFSALRBQ6U7OYAKGQE2T3GKBY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m4si403669wib.0.2015.10.14.16.50.26
        for <rtc-linux@googlegroups.com>;
        Wed, 14 Oct 2015 16:50:26 -0700 (PDT)
Date: Thu, 15 Oct 2015 01:50:26 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v1 0/4] rtc: pcf2127: a fix, a cleanup and two
 questionable features
Message-ID: <20151014235026.GB3421@piout.net>
References: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/10/2015 at 11:17:18 +0200, Uwe Kleine-K=C3=B6nig wrote :
> Hello,
>=20
> the fix and the cleanup should be fine. Patches 3 and 4 are probably
> wrong (but still state of the art for other in-tree drivers) because
> sysfs_create_file is called too late. See
> http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly=
/
> for some details.
>=20
> I failed to find how to do it correctly though:
>  - the attributes are device specific, so device_driver::groups is wrong
>  - for using the i2c's device group it's too late in .probe
>  - the rtc's device is only malloc'd in rtc_device_register and when
>    this returns it's already too late again.
>  - these are neither class nor bus attributes, so these are ruled out, to=
o.
>=20

Most of the drivers currently don't care about that race condition so I
could merge them as-is.
I currently have a PoC that creates the nvram file with the rest of the
sysfs files which solves that. I think this could also be extended to
support battery status.

> Uwe Kleine-K=C3=B6nig (4):
>   rtc: pcf2127: fix reading uninitialized value on RTC_READ_VL ioctl
>   rtc: pcf2127: remove useless driver version
>   rtc: pcf2127: implement reading battery status bits
>   rtc: pcf2127: implement access to nvram
>=20
>  drivers/rtc/rtc-pcf2127.c | 285 ++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 261 insertions(+), 24 deletions(-)
>=20
> --=20
> 2.6.0
>=20

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
