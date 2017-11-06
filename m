Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:48053 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdKFOcW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 6 Nov 2017 09:32:22 -0500
Received: by mail-pf0-f195.google.com with SMTP id z11so7863112pfk.4
        for <linux-rtc@vger.kernel.org>; Mon, 06 Nov 2017 06:32:21 -0800 (PST)
Subject: Re: [PATCH V3] rtc: add support for NXP PCF85363 real-time clock
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, a.zummo@towertech.it,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        otavio.salvador@ossystems.com.br
References: <CAL_Jsq+QQK=NTMBwk=h0uszLW0uSiEd1fmF09USRNFM-2VgiSQ@mail.gmail.com>
 <1509548480-29472-1-git-send-email-eric@nelint.com>
 <20171104160836.bah5su2ld5ckycr3@piout.net>
From: Eric Nelson <eric@nelint.com>
Message-ID: <597958de-7ef0-d715-450c-384cfe2dedd0@nelint.com>
Date: Mon, 6 Nov 2017 07:32:19 -0700
MIME-Version: 1.0
In-Reply-To: <20171104160836.bah5su2ld5ckycr3@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 11/04/2017 09:08 AM, Alexandre Belloni wrote:
> On 01/11/2017 at 08:01:20 -0700, Eric Nelson wrote:

<snip>

>>
>> V3 adds interrupts as an optional property in device tree bindings
>>
>>   drivers/rtc/Kconfig                                |  13 ++
>>   drivers/rtc/Makefile                               |   1 +
>>   drivers/rtc/rtc-pcf85363.c                         | 221 +++++++++++++++++++++
>>   4 files changed, 252 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
>>   create mode 100644 drivers/rtc/rtc-pcf85363.c
>>
> 
> I've tested it (thanks to Fabio, I received one a few weeks ago)
> 
> Applied with the following change:
> 
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -194,7 +194,6 @@ static int pcf85363_probe(struct i2c_client *client,
>          pcf85363->nvmem_cfg.reg_write = pcf85363_nvram_write;
>          pcf85363->nvmem_cfg.priv = pcf85363;
>          pcf85363->rtc->nvmem_config = &pcf85363->nvmem_cfg;
> -       pcf85363->rtc->nvram_old_abi = true;
>          pcf85363->rtc->ops = &rtc_ops;
>   
>          return rtc_register_device(pcf85363->rtc);
> 
> nvram_old_abi must not be used for new drivers and will generate warning
> when the (undocumented) ABI is used anyway.
> 

Thanks Alexandre (and Fabio).
