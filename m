Return-Path: <rtc-linux+bncBDQJZJXU2UMBBCO2YG2QKGQEHPIQV3Y@googlegroups.com>
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id s132si435917wmd.1.2016.02.02.00.47.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2016 00:47:05 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 2/2] doc: dt: add documentation for alphascale,asm9260-rtc
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Rob Herring <robh@kernel.org>
References: <1454056802-23386-1-git-send-email-linux@rempel-privat.de>
 <1454056802-23386-3-git-send-email-linux@rempel-privat.de>
 <20160201152750.GA17595@rob-hp-laptop> <20160201155527.GR20165@piout.net>
Cc: devicetree@vger.kernel.org, a.zummo@towertech.it,
 rtc-linux@googlegroups.com
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <56B06CCA.4060208@rempel-privat.de>
Date: Tue, 2 Feb 2016 09:46:02 +0100
MIME-Version: 1.0
In-Reply-To: <20160201155527.GR20165@piout.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xe087KlWbvSL1W982wrjADLqXjVn2aqou"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xe087KlWbvSL1W982wrjADLqXjVn2aqou
Content-Type: text/plain; charset=UTF-8

Am 01.02.2016 um 16:55 schrieb Alexandre Belloni:
> On 01/02/2016 at 09:27:50 -0600, Rob Herring wrote :
>> On Fri, Jan 29, 2016 at 09:40:02AM +0100, Oleksij Rempel wrote:
>>> Document Alphascale asm9260 RTC bindings
>>>
>>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>>> ---
>>>  .../bindings/rtc/alphascale,asm9260-rtc.txt        | 25 ++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
>>> new file mode 100644
>>> index 0000000..2c0ff3c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
>>> @@ -0,0 +1,25 @@
>>> +* Alphascale asm9260 SoC Real Time Clock
>>> +
>>> +Required properties:
>>> +- compatible: Should be "alphascale,asm9260-rtc"
>>> +- reg: Physical base address of the controller and length
>>> +       of memory mapped region.
>>> +- interrupts: IRQ line for the RTC.
>>> +- clocks: Reference to the clock entry.
>>> +- clock-names: should contain:
>>> +  * "ahb" for the SoC RTC clock
>>> +
>>> +Optional:
>>> +- calibration: calibration value for 1 sec period.
>>> +		Max value for forward calibration is 0x1ffff (131071),
>>> +		Min value for backward calibration is 0xfffe0001 (-131071).
>>
>> This should be prefixed with 'alphascale,'
>>
>> How is this value determined?
>>
> 
> I think this should stay in userspace, see that series:
> https://groups.google.com/forum/#!topic/rtc-linux/HGQqiHnMiuw
> 
> It quite often depends on environmental things like temperature so it may be updated at runtime.
> 

I partially agree. IMO default configuration should work properly by
20C. My devkit provide terrible results without default offset.

-- 
Regards,
Oleksij

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

--Xe087KlWbvSL1W982wrjADLqXjVn2aqou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlawbMoACgkQHwImuRkmbWlwogD5ARDoAS4OCp+gEAe3sA49rdDF
b0jwWtHomClXT8JNYxwA+wYK7L+A+05WKTPDuXJCUgcBreUyBzVvH3IVjLKCwC0H
=yWng
-----END PGP SIGNATURE-----

--Xe087KlWbvSL1W982wrjADLqXjVn2aqou--
