Return-Path: <rtc-linux+bncBDKZNNNLXAHBBFGT4WUAKGQEJFBL5SA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id pc4si1144155pac.0.2015.03.30.08.19.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-MD5 bits=128/128);
        Mon, 30 Mar 2015 08:19:47 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NM1009ZL6RF1Q80@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 30 Mar 2015 16:23:39 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH 0/2] ARM: EXYNOS: Minor S3C RTC cleanups
Date: Mon, 30 Mar 2015 17:19:31 +0200
Message-id: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

Now the s3c6410-rtc is exactly the same as exynos3250-rtc. Mark the
second one as deprecated and switch to one binding.

Patches are independent.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  drivers/rtc/rtc-s3c.c: Integrate Exynos3250 into S3C6410
  ARM: dts: s3c-rtc: Use s3c6410-rtc instead of exynos3250-rtc
  ARM: dts: Use define for s3c-rtc clock id

 Documentation/devicetree/bindings/rtc/s3c-rtc.txt |  3 ++-
 arch/arm/boot/dts/exynos3250-rinato.dts           |  3 ++-
 arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos4415.dtsi                 |  2 +-
 drivers/rtc/rtc-s3c.c                             | 14 +-------------
 5 files changed, 7 insertions(+), 17 deletions(-)

-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
