Return-Path: <linux-rtc-owner@vger.kernel.org>
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCHv2 0/2] rtc: add support for STM32H7 RTC
Date: Thu, 6 Jul 2017 10:47:43 +0200
Message-ID: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

Add support for STM32H7 Real Time Clock variant.
Difference is regarding clocks: there is a 'pclk' clock on STM32H7
for register access.

Amelie Delaunay (2):
  dt-bindings: rtc: stm32: add support for STM32H7
  rtc: stm32: add STM32H7 RTC support

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 +++++++--
 drivers/rtc/rtc-stm32.c                            | 82 +++++++++++++++++-----
 2 files changed, 92 insertions(+), 22 deletions(-)

-- 
1.9.1
