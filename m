Return-Path: <rtc-linux+bncBD6PHS6WQMDRBKVRT7FQKGQENHVMZZY@googlegroups.com>
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com. [2607:f8b0:400e:c05::232])
        by gmr-mx.google.com with ESMTPS id y5si1502655pff.2.2017.07.13.13.31.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 13:31:37 -0700 (PDT)
Received: by mail-pg0-x232.google.com with SMTP id u62so34804445pgb.3
        for <rtc-linux@googlegroups.com>; Thu, 13 Jul 2017 13:31:37 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 3/4] rtc: cros-ec: add cros-ec-rtc driver.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 bleung@chromium.org
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
 Gwendal Grignou <gwendal@chromium.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
 Stephen Barber <smbarber@chromium.org>, 'Benson Leung' <bleung@chromium.org>
References: <20170712101309.6045-1-enric.balletbo@collabora.com>
 <20170712101309.6045-4-enric.balletbo@collabora.com>
From: "'Benson Leung' via rtc-linux" <rtc-linux@googlegroups.com>
Message-ID: <7a2bc3c7-9177-6820-d4a8-38315ad9aace@google.com>
Date: Thu, 13 Jul 2017 13:31:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170712101309.6045-4-enric.balletbo@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CpuwfwiKqjR3soLJHKexfxksNrRLgIsTe"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CpuwfwiKqjR3soLJHKexfxksNrRLgIsTe
Content-Type: multipart/mixed; boundary="qFc2NpHn9DWsn5ipg6TajnVMXel1mBdVd";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 bleung@chromium.org
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
 Gwendal Grignou <gwendal@chromium.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
 Stephen Barber <smbarber@chromium.org>, 'Benson Leung' <bleung@chromium.org>
Message-ID: <7a2bc3c7-9177-6820-d4a8-38315ad9aace@google.com>
Subject: Re: [PATCH v3 3/4] rtc: cros-ec: add cros-ec-rtc driver.
References: <20170712101309.6045-1-enric.balletbo@collabora.com>
 <20170712101309.6045-4-enric.balletbo@collabora.com>
In-Reply-To: <20170712101309.6045-4-enric.balletbo@collabora.com>

--qFc2NpHn9DWsn5ipg6TajnVMXel1mBdVd
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US

Hi Enric,

On 07/12/2017 03:13 AM, Enric Balletbo i Serra wrote:
> From: Stephen Barber <smbarber@chromium.org>
> 
> On platforms with a Chrome OS EC, the EC can function as a simple RTC.
> Add a basic driver with this functionality.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Benson Leung <bleung@chromium.org>

Thanks!
Benson

-- 
Benson Leung
Staff Software Engineer
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

--qFc2NpHn9DWsn5ipg6TajnVMXel1mBdVd--

--CpuwfwiKqjR3soLJHKexfxksNrRLgIsTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZZ9imAAoJEB8J9XsKL+ZY2eAQAJUGfSz4d/+tXzyf7QsQcu9Z
CqtH6UrHvM03LboZBvHaOKxPSK3CiJFj3boDVVPwdpBGKPqsp7kStSw+A/OqkULH
HhJNivgQs3UE+52POrrH9FxbINPZGoccLyAbaNmVEQmPNzRtavcb2VcU4eElM4Qv
rjojM3Cyp15X6xp2HldGCMw1mJk3r+xK3Ydjr7a6qS+2cXfY1Iw+u+go7uJz+1G8
PB/+QrhMuETz/pHzIQi6NJGvQX6cKDQH+wNkcOL7oPx8ySt7mQdECzTrr2cL8iTp
sV23I14YDCVu+JHeoBv9iKDy5iBYSDRt5IPOWSvyVF5VwsY4/H0Ecjh5vtu9ZQrQ
9E2fHI3Yte2f3OUovk2LUrkv1JJTmPxg7WfM77Zj7mRgG5D1/CgckOleFb3FhlWZ
YovvWGu3OIGe+B/yNmsGxCA7aVU0YquMKcetmgrxfef+6zbZTV44Lk41rTARkBEz
MWUbwOdJgEQ9pJwmNOZ89XCTGfGBKdfFFLFYxX+rBFTTh75izU1aIfQuiNdbmdLH
zpprhlMYnHjnp935faGEJ8un7P9bX0LqqHRRQvmitlyuAwGK1bZ9LxZw9mBw0F4O
O0j+a1sFlzVB+faj6gA7BG1vrmBvFf38tDcbaikc9rKeHfkydBZZre+ux+qSNvKV
ZarUXvcPISNKm2QhekB7
=ohJX
-----END PGP SIGNATURE-----

--CpuwfwiKqjR3soLJHKexfxksNrRLgIsTe--
