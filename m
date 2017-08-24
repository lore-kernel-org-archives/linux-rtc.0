Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34565 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbdHXUpK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 16:45:10 -0400
Received: by mail-wr0-f180.google.com with SMTP id z91so1854671wrc.1
        for <linux-rtc@vger.kernel.org>; Thu, 24 Aug 2017 13:45:10 -0700 (PDT)
Subject: Re: rtc: ds1307: call the platform's logic for handle IRQs.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <832da9eb-abed-67c9-1d53-34f19d27c0d9@gmail.com>
 <019f5769-b3ec-2afd-9469-e722b7b0a2e5@gmail.com>
 <b5bed7f5-1963-74fb-dba6-dc465f357645@collabora.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <04725acb-b57f-a303-1be6-2b5d74396f96@gmail.com>
Date: Thu, 24 Aug 2017 22:44:59 +0200
MIME-Version: 1.0
In-Reply-To: <b5bed7f5-1963-74fb-dba6-dc465f357645@collabora.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 24.08.2017 um 22:13 schrieb Enric Balletbo i Serra:
> Hi Heiner
> 
> On 24/08/17 21:16, Heiner Kallweit wrote:
>> Am 24.08.2017 um 20:46 schrieb Heiner Kallweit:
>>> Hi Enric,
>>>
>>> I just saw your submitted patch on patchwork. As I haven't been subscribed
>>> to linux-rtc list yet, I can't reply to the original mail.
>>>
>>> Few remarks:
>>> I think the same can be achieved easier (apart from the fact that member
>>> irq was just removed from struct ds1307).
>>> The curent call to device_set_wakeup_capable has to be replaced with
>>> device_init_wakeup, in addition we have to call dev_pm_set_wake_irq to
>>> register the interrupt with the Linux wakeup core. Then the core takes
>>> care of everything.
>>>
> 
> Oh I just saw your patches, thanks to advice me about them.
> 
>> After further checking not even this may be necessary.
>> If flag I2C_CLIENT_WAKE is set for the i2c client then i2c_device_probe()
>> enables the device as wakeup device and registers the interrupt with the
>> wakeup core.
>> If the i2c client is defined via DT, then of_i2c_register_device() sets
>> this flag based on the "wakeup-source" property.
>> Is your device configured via DT? If yes, did you check whether wakeup
>> works w/o your patch with just setting property wakeup-source ?
>>
> 
> Yes, device is configured via DT and without my patch, just setting property
> wakeup-source didn't work, the reason is that code:
> 
> http://elixir.free-electrons.com/linux/v4.13-rc6/source/drivers/rtc/rtc-ds1307.c#L1382
> 
This shouldn't be the reason because registering the interrupt with the wakeup core
happens earlier in i2c_device_probe().
Can you check whether dev_pm_set_wake_irq() is actually called with the right
irq number in i2c_device_probe()?

Would be interesting to see the DT config of your rtc.

> I didn't test on top of your patches so let me rebase/rethink my patch on top of
> yours.
> 
>>
>>> See also rtc-ds1343, although I think the calls to enable/disable_irq_wake
>>> are not needed there because the core takes care of this already
>>> (enable_irq_wake is called from dev_pm_arm_wake_irq).
>>>
>>> Rgds, Heiner
>>>
>>
> 
> Thanks,
>  Enric
> 
