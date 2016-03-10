Return-Path: <rtc-linux+bncBDU7VC56WAFBBXHBQ23QKGQEHXP6PWY@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id s141si124725wmd.1.2016.03.10.09.37.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 09:37:32 -0800 (PST)
Date: Thu, 10 Mar 2016 18:35:09 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 0/2] rtc: rv3029: Add thermometer support
Message-ID: <20160310183509.7962281b@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JK=qIhRMtdoUWbMPe.0qZmi"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/JK=qIhRMtdoUWbMPe.0qZmi
Content-Type: text/plain; charset=UTF-8

This patch series adds support for configuring and reading the rv3029
RTC thermometer through the standard hwmon interface.

The functionality of the thermometer and the update interval was
checked using a professional heat supplier (hairdryer).

-- 
Michael

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

--Sig_/JK=qIhRMtdoUWbMPe.0qZmi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4bBNAAoJEPUyvh2QjYsOW78QAM5g6BeceNlgYHY8r0rwPNqa
rOcnRfDquYt3Mw6WMornK0fzlYwLeJQ2UqVD6cinhSuKiPSVQjgBrA1A1669ZttK
R6SvcjkG+Wj0VBv4xR7ZwblgbBRk/f/LThbvyIDaTzYCsUut7vEFCIpxad/REluC
hemobOtNDKUJzsp8bVsaNub09/9+Bc5rUR5dme/7FKfJs2L7UYVz9useaa8lUbLt
rFXYwRHQvnEA6m9PFSlpBzSk1TUeXXNn/CKuu3ZA2+tNQWfcsGikopcdywfvC/gF
7LJSJglSyLLvSYqmACJyGtHE/IX2Z6pm9EuPApdx/aGbsAfooJKOLmE4GN0jPCPy
aOpH9wGWbjlZ3fQ5i1U2SAXpoIYPkfk89FWGySlYS68IXoHPZPh0bBLhNonI+KuE
7FF56sriP7wHvrOR4vHDhS7UG0w/2guRfx2f0mpjUK1g5q5DWkZqT07xQgzB89UF
G4L5ENnu3CiRGhUzFR5fIJX894MzTcaGG+CcTNEntN+UjuqfCflCT0peJZNA35Ed
h//dDGgPnG+lr/csdHzq+zPwLX3jRExifWQrhEdD7yzTZhyKMsssXZrfRDt7dcm4
MVRqYeUDifVx9UmtJMS/bVUOdyZBC6NERQDMBHsxVjX8kJWJOGbvcASxdguRwBC/
xLesVEcrjeQ27J5OTjo0
=GxNh
-----END PGP SIGNATURE-----

--Sig_/JK=qIhRMtdoUWbMPe.0qZmi--
