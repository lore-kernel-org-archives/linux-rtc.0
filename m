Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33733 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUnd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Sep 2018 16:43:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so26610671wrc.0
        for <linux-rtc@vger.kernel.org>; Tue, 11 Sep 2018 08:43:40 -0700 (PDT)
Date: Tue, 11 Sep 2018 16:43:37 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and RTC due for the v4.20
 merge window
Message-ID: <20180911154337.GB4185@dell>
References: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

> Lee,
> 
> If that is ok with you, I would like to take this patch through the RTC
> tree. So I can have a follow up patch removing rtc_device_register().

Your wish is my command!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-rtc-v4.20

for you to fetch changes up to 9612f8f503804d2fd2f63aa6ba1e58bba4612d96:

  mfd: menelaus: Fix possible race condition and leak (2018-09-11 16:40:21 +0100)

----------------------------------------------------------------
Immutable branch between MFD and RTC due for the v4.20 merge window

----------------------------------------------------------------
Alexandre Belloni (1):
      mfd: menelaus: Fix possible race condition and leak

 drivers/mfd/menelaus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
