Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34335 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbdHXTQZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 15:16:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id i76so401381wme.1
        for <linux-rtc@vger.kernel.org>; Thu, 24 Aug 2017 12:16:25 -0700 (PDT)
Subject: Re: rtc: ds1307: call the platform's logic for handle IRQs.
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        enric.balletbo@collabora.com
Cc: linux-rtc@vger.kernel.org
References: <832da9eb-abed-67c9-1d53-34f19d27c0d9@gmail.com>
Message-ID: <019f5769-b3ec-2afd-9469-e722b7b0a2e5@gmail.com>
Date: Thu, 24 Aug 2017 21:16:14 +0200
MIME-Version: 1.0
In-Reply-To: <832da9eb-abed-67c9-1d53-34f19d27c0d9@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 24.08.2017 um 20:46 schrieb Heiner Kallweit:
> Hi Enric,
> 
> I just saw your submitted patch on patchwork. As I haven't been subscribed
> to linux-rtc list yet, I can't reply to the original mail.
> 
> Few remarks:
> I think the same can be achieved easier (apart from the fact that member
> irq was just removed from struct ds1307).
> The curent call to device_set_wakeup_capable has to be replaced with
> device_init_wakeup, in addition we have to call dev_pm_set_wake_irq to
> register the interrupt with the Linux wakeup core. Then the core takes
> care of everything.
> 
After further checking not even this may be necessary.
If flag I2C_CLIENT_WAKE is set for the i2c client then i2c_device_probe()
enables the device as wakeup device and registers the interrupt with the
wakeup core.
If the i2c client is defined via DT, then of_i2c_register_device() sets
this flag based on the "wakeup-source" property.
Is your device configured via DT? If yes, did you check whether wakeup
works w/o your patch with just setting property wakeup-source ?


> See also rtc-ds1343, although I think the calls to enable/disable_irq_wake
> are not needed there because the core takes care of this already
> (enable_irq_wake is called from dev_pm_arm_wake_irq).
> 
> Rgds, Heiner
> 
