Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:30592
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750730AbeBPVT1 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Feb 2018 16:19:27 -0500
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180216194415.6103-1-david.daney@cavium.com>
 <CAHp75VfRDWC1DAhHK-B_2rGLdLGG_FjHmYAmRS5ucspaUoJygA@mail.gmail.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <55b1edec-f93d-a25b-1736-d08783576424@caviumnetworks.com>
Date: Fri, 16 Feb 2018 13:19:22 -0800
MIME-Version: 1.0
In-Reply-To: <CAHp75VfRDWC1DAhHK-B_2rGLdLGG_FjHmYAmRS5ucspaUoJygA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/16/2018 12:13 PM, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 9:44 PM, David Daney <david.daney@cavium.com> wrote:
>> The ISL12026 is a combination RTC and EEPROM device with I2C
>> interface.  The standard RTC driver interface is provided.  The EEPROM
>> is accessed via the NVMEM interface via the "eeprom0" directory in the
>> sysfs entry for the device.
> 
>> +config RTC_DRV_ISL12026
>> +       tristate "Intersil ISL12026"
> 
> depends on OF

It doesn't depend on CONFIG_OF, it builds just fine without it.

> 
>> +static struct i2c_driver isl12026_driver = {
>> +       .driver         = {
>> +               .name   = "rtc-isl12026",
>> +               .of_match_table = of_match_ptr(isl12026_dt_match),
> 
> /of_match_ptr//


of_match_ptr() needed if we build without CONFIG_OF

> 
>> +       },
>> +       .probe_new      = isl12026_probe_new,
>> +       .remove         = isl12026_remove,
>> +};
> 
