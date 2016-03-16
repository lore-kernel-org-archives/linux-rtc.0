Return-Path: <rtc-linux+bncBDQJZJXU2UMBBXWQUS3QKGQEN6B2BSQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id c7si76490wmf.2.2016.03.16.02.33.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2016 02:33:18 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: asm9260: remove incorrect __init/__exit annotations
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <1458078287-586232-1-git-send-email-arnd@arndb.de>
 <20160316093008.GB20227@piout.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <56E92854.6060705@rempel-privat.de>
Date: Wed, 16 Mar 2016 10:33:08 +0100
MIME-Version: 1.0
In-Reply-To: <20160316093008.GB20227@piout.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vuJDFXtqKoTnh3HxbkX1Ak6OnEfWGJxx2"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vuJDFXtqKoTnh3HxbkX1Ak6OnEfWGJxx2
Content-Type: multipart/mixed; boundary="q9BmlxwIi3sJSaUGuAeoa8HwG4Q2Agalg"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Message-ID: <56E92854.6060705@rempel-privat.de>
Subject: Re: [PATCH] rtc: asm9260: remove incorrect __init/__exit annotations
References: <1458078287-586232-1-git-send-email-arnd@arndb.de>
 <20160316093008.GB20227@piout.net>
In-Reply-To: <20160316093008.GB20227@piout.net>

--q9BmlxwIi3sJSaUGuAeoa8HwG4Q2Agalg
Content-Type: text/plain; charset=UTF-8

Am 16.03.2016 um 10:30 schrieb Alexandre Belloni:
> Hi,
> 
> On 15/03/2016 at 22:44:31 +0100, Arnd Bergmann wrote :
>> The probe and remove callbacks of the platform driver are marked __init
>> and __exit, respectively. However, this is not a correct way to annotate
>> them, as it will result in those sections to be discarded at link time
>> or after boot, while we can actually call them again based on manual
>> unbinding, or deferred probing.
>>
>> Kbuild warns about the problem:
>>
>> WARNING: drivers/rtc/rtc-asm9260.o(.data+0x0): Section mismatch in reference from the variable asm9260_rtc_driver to the function .init.text:asm9260_rtc_probe()
>>
> 
> I'm not sure why this was not caught before. I'm not building all the
> platform but that one should have been easy to find...

Sorry, i'm working on monolit kernel. Haven't seen this warning before :(

>> This removes the annotations, so we no longer branch into missing
>> code and avoid the warning.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 125e550fd257 ("rtc: add Alphascale asm9260 driver")
>> ---
>>  drivers/rtc/rtc-asm9260.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
>> index 14e08c4c1a01..355fdb97a006 100644
>> --- a/drivers/rtc/rtc-asm9260.c
>> +++ b/drivers/rtc/rtc-asm9260.c
>> @@ -255,7 +255,7 @@ static const struct rtc_class_ops asm9260_rtc_ops = {
>>  	.alarm_irq_enable	= asm9260_alarm_irq_enable,
>>  };
>>  
>> -static int __init asm9260_rtc_probe(struct platform_device *pdev)
>> +static int asm9260_rtc_probe(struct platform_device *pdev)
>>  {
>>  	struct asm9260_rtc_priv *priv;
>>  	struct device *dev = &pdev->dev;
>> @@ -323,7 +323,7 @@ err_return:
>>  	return ret;
>>  }
>>  
>> -static int __exit asm9260_rtc_remove(struct platform_device *pdev)
>> +static int asm9260_rtc_remove(struct platform_device *pdev)
>>  {
>>  	struct asm9260_rtc_priv *priv = platform_get_drvdata(pdev);
>>  
>> -- 
>> 2.7.0
>>
> 


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

--q9BmlxwIi3sJSaUGuAeoa8HwG4Q2Agalg--

--vuJDFXtqKoTnh3HxbkX1Ak6OnEfWGJxx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlbpKFkACgkQHwImuRkmbWlinQD/ZkxW/8Bu1Y/OSnl/WxOJ8J/N
kbvk0TB+Qsismu9PAdcBAI1XYEgpDyy2VkqgMrNU9qJ3hAncTjbzQO/4uzP50GH4
=HD5V
-----END PGP SIGNATURE-----

--vuJDFXtqKoTnh3HxbkX1Ak6OnEfWGJxx2--
