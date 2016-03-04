Return-Path: <rtc-linux+bncBDU7VC56WAFBBDFY463AKGQE2W64HGA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id w128si14358wmd.0.2016.03.04.11.03.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:03:40 -0800 (PST)
Date: Fri, 4 Mar 2016 20:02:56 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 0/6] rtc-rv3029: Add trickle charger
Message-ID: <20160304200256.2d56c790@wiggum>
In-Reply-To: <20160302120045.GO23985@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
 <20160302072627.14e53e94@wiggum>
 <20160302120045.GO23985@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/15pgyMz1HkR.PwsmDg+5Qtt"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/15pgyMz1HkR.PwsmDg+5Qtt
Content-Type: text/plain; charset=UTF-8

This series eventually adds support for the trickle charger mechanism
to the MicroCrystal rv3029 RTC driver.

This series includes the changes from the first review round.
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

--Sig_/15pgyMz1HkR.PwsmDg+5Qtt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2dvgAAoJEPUyvh2QjYsOHZMQAJVbnpDNY5MRTp4mhloRUrcV
QpAK7/pE4RDJ/w5xHXbjK2BSUEe5XBwcdvUJkbudyFYeIxJlGcvi5gAE5FCInVj4
REyVRKYIO6ip8tI1HFAyp0NDi21nTtSOWQJO1Mojck2c7nWSy8YDMp8mq4HixO97
CeN9QF7JB31gksq41MD9SmM+41ZCzkKYrgKTEuL28hTKAQDsv5JynKVy/dnDVExV
gH+Q/+b59R6iFRxH+dw0Gkk0vzhvKxiq1trsZtkSOqlRSOxnhdyydimpC2yx1htm
2u7vF2sF8v5P2mooit1PvGAR6zpVo6sGRmckz0ZucfFXzPGb34Gnzug1qRVmkylE
hZIZzJ19qaevuiMCsR4TbilPWfmUq1V5kM4gjXDJ7PwoSL8hdlVM/kDA+1TSf/tN
o+Jb59/LgLa5b9+E/1jw0uHpkGUsOISHgUPW4yZxx3B0ohcAzjMTuhJ54ifncNgE
fTjn3tgRseJSMYKeoDS+RpMUksEjhIDYvif5ErxyMf50Y9tX9tUIWac+If8ucnoz
vbXs125vRoVAPGcKl7vqRQjXYb99HCAJ+IEAOgQtC97I6LsVjVugJoVa+66as90u
1aHu+UDH8ILFB52P8PXeV6yLEQtSx3kVdxCIX1stPhSkzmjcfho1sx5m7NNfvPpx
BfXz2aRx+AxatJWGnjqp
=sokC
-----END PGP SIGNATURE-----

--Sig_/15pgyMz1HkR.PwsmDg+5Qtt--
