Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44396 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752915AbeDSNew (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 09:34:52 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/3] Introduce STM32MP1 RTC
Date: Thu, 19 Apr 2018 15:34:02 +0200
Message-ID: <1524144845-23016-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This series introduces STM32MP1 RTC.
On STM32MP1:
- two clocks are needed, plck and rtc_ck;
- to wakeup the system, a wakeup alarm interrupt is needed;
- some registers or bits have moved, but the operation is the same;
- the Backup Domain Protection (DBP) is not managed by RTC driver.

Amelie Delaunay (3):
  rtc: stm32: rework register management to prepare other version of RTC
  dt-bindings: rtc: update stm32-rtc documentation for stm32mp1 rtc
  rtc: stm32: add stm32mp1 rtc support

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  27 +-
 drivers/rtc/rtc-stm32.c                            | 272 ++++++++++++++++-----
 2 files changed, 229 insertions(+), 70 deletions(-)

-- 
2.7.4
