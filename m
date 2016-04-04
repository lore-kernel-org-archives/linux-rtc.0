Return-Path: <rtc-linux+bncBDS7HNEFSALRBRXQRK4AKGQE7QUIX4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i196si346007wmf.0.2016.04.04.11.53.58
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Apr 2016 11:53:58 -0700 (PDT)
Date: Mon, 4 Apr 2016 20:53:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/8] rtc: m41t80: update and add functionalities
Message-ID: <20160404185350.GA7190@piout.net>
References: <cover.1459188215.git.mylene.josserand@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <cover.1459188215.git.mylene.josserand@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/03/2016 at 08:55:57 +0200, Myl=C4=8Dne Josserand wrote :
> This patchset updates the m41t80 driver :
>   - update the sysfs entries export to use DEVICE_ATTR_XX
>   - remove some unnecessary macro
>   - replace old i2c functions to smbus ones
>   - use BIT macro
>   - remove some warnings
>   - replace obsolete functions
>=20
> It adds also some functionalities :
>   - alarm IRQ which was previously removed because it was not working
>   - wakealarm to use the RTC and set an alarm to wakeup the system
>   - Oscillator failure to print an error if it is set
>      =20
> Myl=C4=8Dne Josserand (8):
>   rtc: m41t80: update sysfs entries export
>   rtc: m41t80: remove proc macro
>   rtc: m41t80: replace i2c functions to smbus ones
>   rtc: m41t80: add the use of 'BIT' macro
>   rtc: m41t80: remove warnings and replace obsolete function
>   rtc: m41t80: add alarm functionality
>   rtc: m41t80: add wakealarm functionality
>   rtc: m41t80: handle oscillator failure bit
>=20
>  drivers/rtc/rtc-m41t80.c | 443 +++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 289 insertions(+), 154 deletions(-)
>=20

All applied, thanks!

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
