Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57247 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbdK3Jkz (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 30 Nov 2017 04:40:55 -0500
Date: Thu, 30 Nov 2017 11:40:49 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Rabeeh Khoury <rabeeh@solid-run.com>
Subject: Armada RTC power up reset
Message-ID: <20171130094049.fg3zoxgvhlb7jqw3@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Thomas,

As you know, the Armada 38x/8k RTC needs a reset sequence to be operational 
when first powered up. This reset code is currently in the vendor provided 
U-Boot RTC driver. But having to run 'date reset' from the U-Boot prompt every 
first boot (happens quite a lot when dealing with SOMs) is not nice. An 
automatic reset in the kernel driver would be much better.

Rabeeh has mentioned to me that you had an idea how to detect at run time that 
the RTC is in first power up state. Do you recall the details?

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
