Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33337 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbdHXSqZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 14:46:25 -0400
Received: by mail-wr0-f173.google.com with SMTP id f8so1026315wrf.0
        for <linux-rtc@vger.kernel.org>; Thu, 24 Aug 2017 11:46:25 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        enric.balletbo@collabora.com
Cc: linux-rtc@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: rtc: ds1307: call the platform's logic for handle IRQs.
Message-ID: <832da9eb-abed-67c9-1d53-34f19d27c0d9@gmail.com>
Date: Thu, 24 Aug 2017 20:46:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Enric,

I just saw your submitted patch on patchwork. As I haven't been subscribed
to linux-rtc list yet, I can't reply to the original mail.

Few remarks:
I think the same can be achieved easier (apart from the fact that member
irq was just removed from struct ds1307).
The curent call to device_set_wakeup_capable has to be replaced with
device_init_wakeup, in addition we have to call dev_pm_set_wake_irq to
register the interrupt with the Linux wakeup core. Then the core takes
care of everything.

See also rtc-ds1343, although I think the calls to enable/disable_irq_wake
are not needed there because the core takes care of this already
(enable_irq_wake is called from dev_pm_arm_wake_irq).

Rgds, Heiner
