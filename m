Return-Path: <rtc-linux+bncBDS7HNEFSALRBIVWUK4QKGQE3L3IW2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c69si1104443wme.2.2016.05.03.05.35.45
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 05:35:45 -0700 (PDT)
Date: Tue, 3 May 2016 14:35:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH V3 0/7] add support for Microcrystal RV-3049
Message-ID: <20160503123544.GJ2335@piout.net>
References: <cover.1462268107.git.mylene.josserand@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <cover.1462268107.git.mylene.josserand@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/05/2016 at 11:54:31 +0200, Myl=C4=8Dne Josserand wrote :
> The current patchset adds the support of the microcrystal RV-3049 (spi).
> This RTC will use the same driver than RV-3029 by updating it to use regm=
ap.
> It also adds the alarm IRQ functionality.
>=20
> V3:
>  - Create a patch to fix bit mask on bin2bcd for set_time function
>=20
> V2 :
>  - Add some checks removal from checkpatch
>  - Fix the alarm support with a wrong use of bit mask on bin2bcd
>=20
> Myl=C4=8Dne Josserand (7):
>   rtc: rv3029: remove 'i2c' in functions names
>   rtc: rv3029: convert to use regmap
>   rtc: rv3029: Add support of RV3049
>   rtc: rv3029: Remove some checks and warnings
>   rtc: rv3029: fix alarm support
>   rtc: rv3029: fix set_time function
>   rtc: rv3029: add alarm IRQ
>=20
>  drivers/rtc/Kconfig        |  37 +--
>  drivers/rtc/rtc-rv3029c2.c | 582 +++++++++++++++++++++++++++++----------=
------
>  2 files changed, 397 insertions(+), 222 deletions(-)
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
