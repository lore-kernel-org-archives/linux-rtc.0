Return-Path: <rtc-linux+bncBCKMJIMMRQBBBPG7V7CAKGQEAXMXLYQ@googlegroups.com>
Received: from mail-pg0-x236.google.com (mail-pg0-x236.google.com. [2607:f8b0:400e:c05::236])
        by gmr-mx.google.com with ESMTPS id 23si1466435pfw.4.2017.01.27.17.11.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2017 17:11:24 -0800 (PST)
Received: by mail-pg0-x236.google.com with SMTP id 3so26669000pgj.3
        for <rtc-linux@googlegroups.com>; Fri, 27 Jan 2017 17:11:24 -0800 (PST)
Sender: Benson Leung <bleung@google.com>
Date: Fri, 27 Jan 2017 17:11:19 -0800
From: Benson Leung <bleung@chromium.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Stephen Barber <smbarber@chromium.org>, bleung@chromium.org
Subject: [rtc-linux] Re: [PATCH v2 4/4] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170128011119.GA30958@google.com>
Reply-To: rtc-linux@googlegroups.com
References: <20170119123032.24679-1-enric.balletbo@collabora.com>
 <20170119123032.24679-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <20170119123032.24679-4-enric.balletbo@collabora.com>
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Enric,

On Thu, Jan 19, 2017 at 01:30:32PM +0100, Enric Balletbo i Serra wrote:
> From: Stephen Barber <smbarber@chromium.org>
> 
> If the EC supports RTC host commands, expose an RTC device.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Benson Leung <bleung@chromium.org>

Sorry for the delay on this Enric. This looks good to go.

-- 
Benson Leung
Senior Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJYi++3AAoJEB8J9XsKL+ZYG1gQAKbBLiPDhf1rL5U9MLhlCmMG
NTa7O32r7e3m3rCeHWYq29csDgA9ZVTHVolLDc0Knl/38Sp9HoSIb5Yl08cmbx0X
vLU55uVhebvFEGb0/O2/8CGLQAFpWg4n/sIijdSEDer4EOepqknKfbgo78AzEtmp
NJco86XqhfC7LA3/TR3K60E59p0HSISlAvJo5HIJOArZa83Z6NatjhXHXJV1iyl2
4edROThwWAo0gQ2MbchcnPfKqryNUoKWmGc+RAfW46DgwR/lhgamG90i5GhxVsg5
WduE08Qk3NAyGnbUzL876FuraJrBkT+yxLkrxFdRNaBarcsbx5ZOxDXnk7vouEpW
RZf7+YL33TL35pzqN8i4V/wjIRc9y5Wz5ixAgH61NdkRKYPl3AJeeStHVymnnY3y
rYjmlZfkTsL8XnFqOXvQai3Sx3kQ6mCiC61FpkDaMMTSbP7Rmw4muws6tBX0jjb0
1KnRCOZ+Eyv3oWKhWtvmCQGXdgDoqybN/hOVhg9MitQ5RkchTsp+GRLZ6y938Deo
9OUjFqYotUZSyPenEzo5WATF6LFsqPmUGpt3gVyzz8qt1m/kqgglG4GpdI+WjaE8
wkbMVpBjCKRLHSBZnswVdDXhB1WvueTVUNr5GCif4KY9N8WOsgna+SD9JksLbUaj
nbPzVhM9sSpKnJWwsIQY
=R4a6
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
