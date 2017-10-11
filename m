Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:51649 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757543AbdJKPIe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 11 Oct 2017 11:08:34 -0400
Received: by mail-pg0-f41.google.com with SMTP id k70so110773pgc.8
        for <linux-rtc@vger.kernel.org>; Wed, 11 Oct 2017 08:08:34 -0700 (PDT)
Subject: Re: [PATCH] rtc: add support for NXP PCF85363 real-time clock
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio.salvador@ossystems.com.br>
References: <1507578100-2148-1-git-send-email-eric@nelint.com>
 <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
From: Eric Nelson <eric@nelint.com>
Message-ID: <cc764cec-0f83-5d8f-d4b8-02f4b2cd8627@nelint.com>
Date: Wed, 11 Oct 2017 08:08:31 -0700
MIME-Version: 1.0
In-Reply-To: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Fabio,

On 10/10/2017 06:31 AM, Fabio Estevam wrote:
> Hi Eric,
> 
> On Mon, Oct 9, 2017 at 4:41 PM, Eric Nelson <eric@nelint.com> wrote:
> 
>> +config RTC_DRV_PCF85363
>> +       tristate "NXP PCF85363"
>> +       depends on I2C
> 
> It seems you missed a dependency on REGMAP_I2C.
> 

Nice catch. Thanks.

>> +static const struct i2c_device_id pcf85363_id[] = {
>> +       { "pcf85363", 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, pcf85363_id);
> 
> Even though the driver can probe via the i2c device id, it is
> recommended to explicitly pass the compatible string:
> 
> static const struct of_device_id pcf85363_dt_match[] = {
> { .compatible = "nxp,pcf85363" },
> { },
> 
> See this previous discussion:
> https://www.spinics.net/lists/devicetree/msg195176.html
> 
Thanks for that, too.

I'll fix this up in V2.
