Return-Path: <rtc-linux+bncBDAYD2P3QYGRBVPVWO5QKGQE76O54EA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id q124si83574wme.3.2016.06.24.02.18.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 02:18:12 -0700 (PDT)
Received: by mail-wm0-x233.google.com with SMTP id r201so16814317wme.1
        for <rtc-linux@googlegroups.com>; Fri, 24 Jun 2016 02:18:12 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: dmitry.torokhov@gmail.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	lee.jones@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2 0/5] Add support for the Qualcomm PM8018 PMIC
Date: Fri, 24 Jun 2016 11:18:02 +0200
Message-Id: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

In order to support the Qualcomm MDM9615 in the Sierra Wireless WP8548
Modules, add the PM8018 PMIC support into MFD, Regulator, RTC and input.

This patchset is part of a global SoC + Module + Board support for the
Sierra Wireless mangOH Board support with the WP8548 module.

Patch "mfd: qcom-rpm: Add support for pm8018 RPM Regulator" depends on :
 - "fix offset error for msm8660" at http://lkml.kernel.org/r/1465897725-16213-1-git-send-email-linus.walleij@linaro.org
 - "parametrize also ack selector size" at http://lkml.kernel.org/r/1466576837-21995-1-git-send-email-linus.walleij@linaro.org

Changes since v1 at http://lkml.kernel.org/r/1466158929-19524-1-git-send-email-narmstrong@baylibre.com :
 - Rebase mfd/qcom_rpm.c on top of Linus "fix offset error for msm8660" and "parametrize also ack selector size" patches
 - Rename QCOM_RPM_NCP in to QCOM_RPM_PM8018_NCP
 - Rebased qcom-rpm.h PM8018 defines numbers without a gap
 - Dropped regulator corner

Neil Armstrong (5):
  mfd: pm8921: Add support for pm8018
  input: pmic8xxx-pwrkey: Add support for pm8018 pwrkey
  rtc: rtc-pm8xxx: Add support for pm8018 rtc
  mfd: qcom-rpm: Add support for pm8018 RPM Regulator
  regulator: qcom_rpm-regulator: Add support for pm8018 rpm regulator

 .../bindings/input/qcom,pm8xxx-pwrkey.txt          |   1 +
 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  15 ++++
 drivers/input/misc/pmic8xxx-pwrkey.c               |   1 +
 drivers/mfd/pm8921-core.c                          |   1 +
 drivers/mfd/qcom_rpm.c                             |  51 +++++++++++
 drivers/regulator/qcom_rpm-regulator.c             | 100 +++++++++++++++++++++
 drivers/rtc/rtc-pm8xxx.c                           |  11 +++
 include/dt-bindings/mfd/qcom-rpm.h                 |  22 +++++
 9 files changed, 203 insertions(+)

-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
