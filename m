Return-Path: <rtc-linux+bncBDU7VC56WAFBBQPKY23AKGQEI6UYYMQ@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id c140si11187wmh.1.2016.02.27.06.40.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 27 Feb 2016 06:40:01 -0800 (PST)
Date: Sat, 27 Feb 2016 15:39:18 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Gregory Hermant <gregory.hermant@calao-systems.com>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160227153918.3c3d3853@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4C/N2hoVcqv4Sz_4X50ecqc"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/4C/N2hoVcqv4Sz_4X50ecqc
Content-Type: text/plain; charset=UTF-8

Hi,

I'm currently trying to use the Linux RV3029 RTC driver for one of my
applications. So far the basic functionality works fine.
However I need a way to (initially) program the EEPROM on the RTC chip
to enable such things as temperature compensation or the trickle
charger.
As of now the Linux driver does not support that though. So I'm
wondering how we should implement that. As an initial idea I think we
could have about some sysfs attributes for these settings. Is there a
better way (more standard API) to do this?
If not, I'll do an implementation of this based on sysfs attributes.

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

--Sig_/4C/N2hoVcqv4Sz_4X50ecqc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0bUXAAoJEPUyvh2QjYsOk3cQAJ4raKV1QhrX/DGkKOEE69df
6MPnExV4q13BTnvDLGb3GobnOsUK/sllU562NI6xTgDoXtPubljZAhpstSmuWqDw
TxfEM7BgWAmNBx0u+wqtfpRaDTDL+qF93qkRgBde20EaOhqWrRXbhkHcM5xs8QOp
FXEaT9F26T7xz2bberc/BSstnF/6BrZl9BAxhNkdn/sxFoxUMOgFIbnhhfM/if2U
QGlUD1GxzAyWcQN42WU41sctcmxxOx3WsI7m8yq07iQypY5X0R7a6C7pcJDetT0s
gjbScMCdyklSgM/hqb3aT+Cx1zqiIEW2qiV32tame/aifhX8Q7qx7T2sdiN2Pbz7
jiaPCHpDRPUNIhvSMn4ftzzKsp7T3UD0vEll19q1sO1CmnSlkT39geJSRHsVY1Xu
npP5j65vKf3jj27rC0e/XXcUqZz3VhJ1hOnKDogMJ1Pgx3GErxFT3KhwdrTPdTzz
rfrNlQioEsolnQUViKmhpF4cTmkDPRHl3KRjl6KnxdxcohVRCP5g38SptQmSyxqq
fL1YlzKBhMRVxAbUhoeTypzZIP9AOx9dWbeKlYo8M2152hgQfMMwefJS244sNbW1
oqk8ZCdP4ZDkOcYHHyAlQTdBIzUQvO4I0rRNN4h1S/Mchl97eUkaNekXgDknQUNs
3IAEYpkNTdmHouwtZGZg
=QVdL
-----END PGP SIGNATURE-----

--Sig_/4C/N2hoVcqv4Sz_4X50ecqc--
