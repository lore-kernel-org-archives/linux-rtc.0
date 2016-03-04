Return-Path: <rtc-linux+bncBDU7VC56WAFBBPUD5C3AKGQET4TK3DI@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id v68si30302wmd.1.2016.03.04.13.44.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 13:44:30 -0800 (PST)
Date: Fri, 4 Mar 2016 22:36:54 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v3 0/6] rtc-rv3029: Add trickle charger
Message-ID: <20160304223654.7a02abde@wiggum>
In-Reply-To: <20160304200256.2d56c790@wiggum>
References: <20160301213322.661fe771@wiggum>
	<20160301213655.GG23985@piout.net>
	<20160301225401.3f0aeabb@wiggum>
	<20160301230745.GJ23985@piout.net>
	<20160302072627.14e53e94@wiggum>
	<20160302120045.GO23985@piout.net>
	<20160304200256.2d56c790@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7Qe9Ex=BA0/oKhu=BYMth2M"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/7Qe9Ex=BA0/oKhu=BYMth2M
Content-Type: text/plain; charset=UTF-8

This series eventually adds support for the trickle charger mechanism
to the MicroCrystal rv3029 RTC driver.

This series includes the changes from the first and second review round.

The tricke charger functionality was verified on a rv3029 connected to
a RaspberryPi. The resistance between VCC and the battery pin was
measured for some 'trickle-resistor-ohms' settings.

The series is also available in this git repository:

git://git.bues.ch/linux.git rv3029

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

--Sig_/7Qe9Ex=BA0/oKhu=BYMth2M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2f/2AAoJEPUyvh2QjYsOalYQAKhmSUF4HFsoNlyRqxZn3UY1
GKedALKdjERm55p+e22FF9fD97s3wfGttwya6iFvPOC2VE5inoWGA5eO1rlg8d3Y
cyUIqAxOHYR8OiAO3tT4v8QmQ2n5sbjXH2PqUxZm6beBbuTI26CPnd2+F/VXdE4X
w2qUaz/NsWDweXUzSFzoo2sKSwvJgtwpBikitdXwTzoIiAaFnYsmzFNWMKIUB/n7
8otao4fNdFrcuvtRXqdhYN1c2Udg5AF2a5PawX3+jLzOncBEyVQPVY5jpSRiXo0i
alRLnKH1Ays9QuOk6i6nEuqOm8VCrWaQU5fk0mZGx2Yrf2SkBg7JmgeLFwJkZUou
1e8//9h6BHpokOUBqwrcePy293K4N8kWtS/11Ns4kDSWQnlcyzjUeYsSOk48Svc2
Oaqm+QRDxlf5yGsWLewHY79hiLMciDlGmA8ONN4rNd1Xk45SgJvp72fTyhBFcI5u
5bs8giM9McTEuo8Tj0EAPO5qmI+9jFTP4G/KmZlmTcNroHe8BlSGpOM/C1uXdrcu
t+lMLYIUUHVdMPu1VnHrVaWggL6qfTOea0NuGvds70dr/Rl90yOaBR5piBIF7lTr
/FNWqWPLTMIrAjah+2wrxJDca1bMLUPyi/hv1i3Ilv34B56xyGjoUqLZESMD3e+E
oaBTDspVNyCeUoLc0q3F
=40dX
-----END PGP SIGNATURE-----

--Sig_/7Qe9Ex=BA0/oKhu=BYMth2M--
