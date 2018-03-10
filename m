Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway20.websitewelcome.com ([192.185.48.38]:39095 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750735AbeCJGsH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 10 Mar 2018 01:48:07 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 00661400CF728
        for <linux-rtc@vger.kernel.org>; Sat, 10 Mar 2018 00:27:04 -0600 (CST)
Date: Sat, 10 Mar 2018 00:27:02 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 0/2] Remove VLA usage in rtc-s5m
Message-ID: <cover.1520660422.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patchset aims to remove VLA usage from rtc-s5m.

The first patch moves an enum from rtc.h to rtc-s5m.c, as this is the
only driver in which such enum is actually being used [1].

The second patch adds the enum name RTC_MAX_NUM_TIME_REGS, which will
be used as a maximum length to the current VLAs, hence turning them
into fixed-length arrays instead.

[1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2

Thanks

Gustavo A. R. Silva (2):
  rtc: s5m: move enum from rtc.h to rtc-s5m.c
  rtc: s5m: Remove VLA usage

 drivers/rtc/rtc-s5m.c           | 25 +++++++++++++++++++------
 include/linux/mfd/samsung/rtc.h | 11 -----------
 2 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.7.4
