Return-Path: <rtc-linux+bncBD47PQ46SILBB3VTUXBAKGQEHFZTTYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wj0-x22d.google.com (mail-wj0-x22d.google.com. [2a00:1450:400c:c01::22d])
        by gmr-mx.google.com with ESMTPS id e134si1329018wmd.3.2016.12.08.05.02.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 05:02:37 -0800 (PST)
Received: by mail-wj0-x22d.google.com with SMTP id tk12so92883275wjb.3
        for <rtc-linux@googlegroups.com>; Thu, 08 Dec 2016 05:02:37 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d10sm36878747wja.20.2016.12.08.05.02.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 05:02:36 -0800 (PST)
To: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
From: Michal Simek <monstr@monstr.eu>
Subject: [rtc-linux] RTC used as a module
Message-ID: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
Date: Thu, 8 Dec 2016 14:02:36 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="eg5UrQSnl3j2ViutG0AlXV3pvLIJ9i1TL"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eg5UrQSnl3j2ViutG0AlXV3pvLIJ9i1TL
Content-Type: multipart/mixed; boundary="snU9s4Jgmi4LMr4exwIqCs48CaJngaJrR";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: rtc-linux@googlegroups.com
Message-ID: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
Subject: RTC used as a module

--snU9s4Jgmi4LMr4exwIqCs48CaJngaJrR
Content-Type: text/plain; charset=UTF-8

Hi guys,

I am trying to find out reason for this behavior. If rtc-zynqmp is used
as module for the first time it is correctly probed based on aliases
setting. (rtc5 for log below). But then driver is removed and add again
rtc5 is still not freed. rtc_device_release() is not called that's why
rtc->id can't be used again.

sh-4.3# modprobe rtc-zynqmp
[   42.468565] rtc_zynqmp ffa60000.rtc: rtc core: registered
ffa60000.rtc as rtc5
sh-4.3# rmmod rtc-zynqmp
sh-4.3# modprobe rtc-zynqmp
[   48.648222] rtc_zynqmp ffa60000.rtc: /aliases ID 5 not available
[   48.654280] rtc_zynqmp ffa60000.rtc: rtc core: registered
ffa60000.rtc as rtc0


I didn't try different rtc drivers but it looks like that someone keeps
reference that's why release function is not called.

Can someone check this with different RTC module?
Or is this expected behavior?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--snU9s4Jgmi4LMr4exwIqCs48CaJngaJrR--

--eg5UrQSnl3j2ViutG0AlXV3pvLIJ9i1TL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlhJWewACgkQykllyylKDCEj2wCeKuGom2UTAVJ9E/+uVjCKpVwO
ULwAn2jCqvcXc1wgmFinTVpb/gLqBU4b
=SirJ
-----END PGP SIGNATURE-----

--eg5UrQSnl3j2ViutG0AlXV3pvLIJ9i1TL--
