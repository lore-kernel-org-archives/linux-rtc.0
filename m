Return-Path: <rtc-linux+bncBC5M7T4HYEKRB7X7VKWAKGQEZP7KEMI@googlegroups.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com. [192.94.94.40])
        by gmr-mx.google.com with ESMTPS id o7si189757igp.1.2015.06.24.07.34.37
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 07:34:37 -0700 (PDT)
Date: Wed, 24 Jun 2015 09:34:32 -0500
From: Felipe Balbi <balbi@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <balbi@ti.com>, <grygorii.strashko@ti.com>
Subject: [rtc-linux] Re: [PATCH V2 0/5] drivers/rtc/rtc-ds1307.c: Basic
 cleanups and support for wakeupirq
Message-ID: <20150624143432.GE21232@saruman.tx.rr.com>
Reply-To: rtc-linux@googlegroups.com
References: <1435076114-12416-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2015 at 11:15:09AM -0500, Nishanth Menon wrote:
> Hi,
> 
> Here is the revamp of the patch posted eariler to support wakeupirq.
> This series does a few cleanups as well prior to introducing the
> generic apis required to support the wakeirq mechanism used on certain
> TI SoCs. Cleanups done here are just minimal set of the cleanups we
> discussed in [2].
> 
> Series is based on next-20150623
> 
> Test log: http://pastebin.ubuntu.com/11763002/
> 
> NOTE1: I have only tested in mcp79410 device, and not on other
> ds1307-rtc driver compatbile devices as I dont have any other.
> additional testing might be nice to have.
> NOTE2: there are additional fixes that linux-next seems to need but
> those are in omap-rtc, cpufreq etc, but those are not related by the
> ds-1307.
> 
> V1: https://patchwork.kernel.org/patch/4759171/
> 
> NOTE: Patch 5/5 of the series is meant to indicate the usage, and will
> be reposted along with other wakeup sources to be enabled once the
> driver changes are accepted.
> 
> Felipe Balbi (1):
>   drivers/rtc/rtc-ds1307.c: Convert to threaded IRQ
> 
> Nishanth Menon (4):
>   drivers/rtc/rtc-ds1307.c: Switch to managed irq allocation
>   drivers/rtc/rtc-ds1307.c: Sort the headers
>   drivers/rtc/rtc-ds1307.c: Support optional wakeup interrupt source

for the series, except the patch which I wrote :

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi

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

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVir/4AAoJEIaOsuA1yqREfxMQAKWlVvUcPrDpUMPK48OO8bZa
Anm+UEMGwQmMYSSG3Cg575viJOH8LsagnPfdzaveq2ZKs5aPnAHu2MKjHBOM1Tqs
CrIDLgZVUT/VyOKJ+OmqWn5xpCXYlkVlZeO/6CimqKfzAYFsGGeTr0EJQkA9YAP+
JSK4teeX/5Ryz76MtJNK6W/qQ50ahIK36Nw9+00mJ8AXEnlAi5mDGjDJBA2Uzm/g
9cXaZHQbdz3MEB3Dt1qpvlwCKGrHqZ2QZVTCMNJHACfffGH2ApqLYdgsRuXk3gkm
WGCMAEtsaac9SlyzBFYcys8HV0yETgFiDSAXHL8fyW1Z4H8sNNpdjbdZGyQz2kOI
uhAUWBJJks0w7O0P3cIZIVW8j7de3IS8seUPVRmqbQlW8Fx2XpyXWh3so2baigHR
PET074oA19SLwlVPbyUF0JusIqlZk4GfUcKCIy5LI8z4563inZRiDqCqCvH5GM4p
BgyljhPG7BvyMJczeAgwmfEM0sng3bllxvTmqjW1lfNKbi72Ns814E5mB0q8WT+i
I+OBXA29IOtnJ2YgnoNd26OX6+fiurvkr4HZz2V0OnbHg0zuJsbP6Rt+55UUu+tZ
6JE1sYBkBZHNo9iepJ07y+eKeQhxKDNeSZ0f4M30f5kZq2cfSBWg1eIed4nAXY5c
vmF8X068D5SFFRzaVObW
=fSug
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
