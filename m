Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:45173 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeBSGLq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 19 Feb 2018 01:11:46 -0500
Received: by mail-lf0-f41.google.com with SMTP id x196so11458414lfd.12
        for <linux-rtc@vger.kernel.org>; Sun, 18 Feb 2018 22:11:45 -0800 (PST)
Received: from [192.168.1.10] ([185.9.184.158])
        by smtp.gmail.com with ESMTPSA id r13sm972446lff.52.2018.02.18.22.11.43
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2018 22:11:43 -0800 (PST)
To: linux-rtc@vger.kernel.org
From: Igor Plyatov <plyatov@gmail.com>
Subject: Delay in time saved into RTC
Message-ID: <1f793eed-8f04-359d-0088-a4021f705356@gmail.com>
Date: Mon, 19 Feb 2018 09:11:42 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi!

I have board based on AT91SAM9G20 (ARM926EJ-S CPU), Linux-4.9.36 kernel 
and I2C RTC chip DS1340 (rtc-ds1307.c driver) without HW IRQ line connected.

Kernel configured to not use embedded functions for time getting at 
startup and saving at shutdown:
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y

The hwclock utility is from util-linux-2.29.1.

The OS does not have external time synchronization sources like NTP, PTP 
or else.

Generally I need to achieve error within +-20 ms when RTC's time copied 
into OS or back from OS into RTC.

I have made measurements during startup and shutdown of OS and have 
found 500 ms delay introduced into RTC's time, when "hwclock --utc 
--systohc" executed.

Logical analyzer show I2C-bus transactions and 500 ms delay corresponds 
to a gap between moments when RTC's time polled for beginning of new 
second and when time really saved into RTC.

Please explain, why this happens?

Is this due to absence of IRQ line for RTC or due to a bug in the 
hwclock, or kernel bug or I have missed something else?

Best wishes.
--
Igor Plyatov
