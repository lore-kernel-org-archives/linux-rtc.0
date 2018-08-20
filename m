Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:56074 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeHTWfR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 20 Aug 2018 18:35:17 -0400
Date: Mon, 20 Aug 2018 21:18:17 +0200
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, od@zcrc.me,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1534792697.1744.0@crapouillou.net>
In-Reply-To: <20180820191247.GU21707@piout.net>
References: <20180820180716.1853-1-paul@crapouillou.net>
        <20180820191247.GU21707@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

Le lun. 20 ao=FBt 2018 =E0 21:12, Alexandre Belloni=20
<alexandre.belloni@bootlin.com> a =E9crit :
> On 20/08/2018 20:07:16+0200, Paul Cercueil wrote:
>>  Depending on MACH_INGENIC prevent us from creating a generic kernel=20
>> that
>>  works on more than one MIPS board. Instead, we just depend on MIPS=20
>> being
>>  set.
>=20
> Maybe you could consider dropping the whole dependency as we already
> know it will build on every architecture.

Well, I didn't really want the Kconfig option to show on the menu when
compiling for non-MIPS, since it's only ever useful there.

Should I drop the dependency then?

>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/rtc/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>>  index a2ba5db36145..98c7f19256b1 100644
>>  --- a/drivers/rtc/Kconfig
>>  +++ b/drivers/rtc/Kconfig
>>  @@ -1608,7 +1608,7 @@ config RTC_DRV_MPC5121
>>=20
>>   config RTC_DRV_JZ4740
>>   	tristate "Ingenic JZ4740 SoC"
>>  -	depends on MACH_INGENIC || COMPILE_TEST
>>  +	depends on MIPS || COMPILE_TEST
>>   	help
>>   	  If you say yes here you get support for the Ingenic JZ47xx SoCs=20
>> RTC
>>   	  controllers.
>>  --
>>  2.11.0
>>=20
>=20
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
=
